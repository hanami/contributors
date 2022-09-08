package main

import (
	"context"
	"database/sql"
	"flag"
	"log"
	"os"
	"strings"
	"time"

	_ "github.com/mattn/go-sqlite3"

	"github.com/google/go-github/v47/github"
	"golang.org/x/oauth2"
)

func main() {
	daily := flag.Bool("daily", false, "fetch only commits for the latest 24/48hrs")

	githubToken, present := os.LookupEnv("GH_TOKEN")
	if !present {
		log.Fatal("GH_TOKEN env variable is missing")
	}

	ctx := context.Background()
	ts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: githubToken},
	)
	tc := oauth2.NewClient(ctx, ts)
	client := github.NewClient(tc)

	db, err := sql.Open("sqlite3", "./db/production.db")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	log.Println("Fetching repositories...")
	repositories, err := fetchRepositories(client)
	if err != nil {
		log.Fatal(err)
	}

	for _, repository := range repositories {
		log.Printf("Processing: %s", *repository.Name)
		commits, err := fetchCommits(client, repository, daily)
		if err != nil {
			log.Fatal(err)
		}

		err = persistCommits(db, repository, commits)
		if err != nil {
			log.Fatal(err)
		}
	}

	err = refreshContributorsSinceDate(db)
	if err != nil {
		log.Fatal(err)
	}
}

func fetchRepositories(client *github.Client) ([]*github.Repository, error) {
	opt := &github.RepositoryListByOrgOptions{
		ListOptions: github.ListOptions{PerPage: 100},
	}

	var allRepos []*github.Repository

	for {
		repos, resp, err := client.Repositories.ListByOrg(context.Background(), "hanami", opt)

		if err != nil {
			return allRepos, err
		}

		allRepos = append(allRepos, repos...)
		if resp.NextPage == 0 {
			break
		}

		opt.Page = resp.NextPage
	}

	return allRepos, nil
}

func fetchCommits(client *github.Client, repository *github.Repository, daily *bool) ([]*github.RepositoryCommit, error) {
	opt := &github.CommitsListOptions{
		ListOptions: github.ListOptions{PerPage: 100},
	}

	if daily != nil && *daily == true {
		opt.Since = time.Now().UTC().AddDate(0, 0, -2) // two days ago
	}

	var allCommits []*github.RepositoryCommit

	tokens := strings.Split(*repository.FullName, "/")

	for {
		commits, resp, err := client.Repositories.ListCommits(context.Background(), tokens[0], tokens[1], opt)

		if err != nil {
			return allCommits, err
		}

		allCommits = append(allCommits, commits...)
		if resp.NextPage == 0 {
			break
		}

		opt.Page = resp.NextPage
		waitToAvoidRateLimiting()
	}

	return allCommits, nil
}

func persistCommits(db *sql.DB, repository *github.Repository, commits []*github.RepositoryCommit) error {
	repositoryID, err := upsertRepository(db, repository)
	if err != nil {
		return err
	}

	for _, commit := range commits {
		log.Printf("processing commit %s (%s)", *commit.SHA, *repository.Name)
		var contributor *github.User

		if commit.Author != nil {
			contributor = commit.Author
		} else {
			contributor = commit.Committer
		}

		if contributor == nil {
			continue
		}

		contributorID, err := upsertContributor(db, contributor)
		if err != nil {
			return err
		}

		err = upsertCommit(db, repositoryID, contributorID, commit)
		if err != nil {
			return err
		}
	}

	return nil
}

func upsertRepository(db *sql.DB, repository *github.Repository) (int64, error) {
	tx, err := db.Begin()
	if err != nil {
		return 0, err
	}

	stmt, err := tx.Prepare("INSERT INTO repositories(id, name) VALUES(NULL, ?) ON CONFLICT(name) DO NOTHING")
	if err != nil {
		return 0, err
	}
	defer stmt.Close()

	_, err = stmt.Exec(repository.FullName)
	if err != nil {
		return 0, err
	}

	err = tx.Commit()
	if err != nil {
		return 0, err
	}

	stmt, err = db.Prepare("SELECT id FROM repositories WHERE name = ?")
	if err != nil {
		return 0, err
	}
	defer stmt.Close()
	var id int64
	err = stmt.QueryRow(repository.FullName).Scan(&id)
	if err != nil {
		return 0, err
	}

	return id, nil
}

func upsertContributor(db *sql.DB, contributor *github.User) (int64, error) {
	tx, err := db.Begin()
	if err != nil {
		return 0, err
	}
	stmt, err := tx.Prepare("INSERT INTO contributors(id, login, full_name) VALUES(NULL, ?, ?) ON CONFLICT(login) DO NOTHING")
	if err != nil {
		return 0, err
	}
	defer stmt.Close()

	_, err = stmt.Exec(contributor.Login, contributor.Name)
	if err != nil {
		return 0, err
	}

	err = tx.Commit()
	if err != nil {
		return 0, err
	}

	stmt, err = db.Prepare("SELECT id FROM contributors WHERE login = ?")
	if err != nil {
		return 0, err
	}
	defer stmt.Close()
	var id int64
	err = stmt.QueryRow(contributor.Login).Scan(&id)
	if err != nil {
		return 0, err
	}

	return id, nil
}

func upsertCommit(db *sql.DB, repositoryID int64, contributorID int64, repositoryCommit *github.RepositoryCommit) error {
	tx, err := db.Begin()
	if err != nil {
		return err
	}
	stmt, err := tx.Prepare("INSERT INTO commits(id, repository_id, contributor_id, sha, url, message, date) VALUES(NULL, ?, ?, ?, ?, ?, ?) ON CONFLICT(repository_id, sha) DO NOTHING")
	if err != nil {
		return err
	}
	defer stmt.Close()

	commit := repositoryCommit.Commit
	var date *time.Time

	if commit.Author != nil {
		date = commit.Author.Date
	} else {
		date = commit.Committer.Date
	}

	// fmt.Printf("%#v \n", commit)

	_, err = stmt.Exec(repositoryID, contributorID, repositoryCommit.SHA, repositoryCommit.HTMLURL, commit.Message, date)
	if err != nil {
		return err
	}

	err = tx.Commit()
	if err != nil {
		return err
	}

	return nil
}

func refreshContributorsSinceDate(db *sql.DB) error {
	tx, err := db.Begin()
	if err != nil {
		return err
	}
	stmt, err := tx.Prepare("UPDATE contributors SET since = (SELECT MIN(date) FROM commits WHERE contributor_id = contributors.id)")
	if err != nil {
		return err
	}
	defer stmt.Close()
	_, err = stmt.Exec()
	if err != nil {
		return err
	}

	err = tx.Commit()
	if err != nil {
		return err
	}

	return nil
}

func waitToAvoidRateLimiting() {
	time.Sleep(3 * time.Second)
}
