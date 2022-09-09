CREATE TABLE IF NOT EXISTS repositories (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS contributors (
  id INTEGER PRIMARY KEY,
  login TEXT NOT NULL UNIQUE,
  full_name TEXT,
  since TEXT,
  commits_count INTEGER NOT NULL DEFAULT(0)
);

CREATE TABLE IF NOT EXISTS commits (
  id INTEGER PRIMARY KEY,
  repository_id INTEGER,
  contributor_id INTEGER,
  sha TEXT NOT NULL,
  url TEXT NOT NULL,
  message TEXT NOT NULL,
  committed_at TEXT NOT NULL,
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

CREATE INDEX IF NOT EXISTS index_contributors_since
ON contributors (since);

CREATE INDEX IF NOT EXISTS index_contributors_commits_count
ON contributors (commits_count);

CREATE UNIQUE INDEX IF NOT EXISTS index_commits_repository_sha
ON commits (repository_id, sha);

CREATE INDEX IF NOT EXISTS index_commits_committed_at
ON commits (committed_at);
