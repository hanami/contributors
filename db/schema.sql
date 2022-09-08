CREATE TABLE IF NOT EXISTS repositories (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS contributors (
  id INTEGER PRIMARY KEY,
  login TEXT NOT NULL UNIQUE,
  full_name TEXT,
  since TEXT
);

CREATE TABLE IF NOT EXISTS commits (
  id INTEGER PRIMARY KEY,
  repository_id INTEGER,
  contributor_id INTEGER,
  sha TEXT NOT NULL,
  url TEXT NOT NULL,
  message TEXT NOT NULL,
  date TEXT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT (datetime('now', 'utc')), 

  FOREIGN KEY (repository_id) 
      REFERENCES repositories (id) 
         ON DELETE CASCADE 
         ON UPDATE NO ACTION,
  FOREIGN KEY (contributor_id) 
      REFERENCES contributors (id) 
         ON DELETE CASCADE 
         ON UPDATE NO ACTION
);

CREATE UNIQUE INDEX index_commits_repository_sha
ON commits (repository_id, sha);

CREATE INDEX index_commits_date
ON commits (date);
