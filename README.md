# Hanami Contributors

Display all Hanami contributors on the one page.

## How it works

GitHub Actions daily job that:

1. fetches the contributions data from GitHub and stores it in a local SQLite database (`db/production.db`)
2. rebuilds the website

## JSON API

### `GET /api/contributors`

```
{
  "count": Integer,
  "data":[{
    "github": String,
    "avatar_url": String,
    "since": "2017-03-08 09:00:56 UTC",
    "commits_count": Integer
  },
  ...
  ]
}
```

### `GET /api/contributors/:github`

```
{
  "status": "ok",
  "contributor": {
    "github": String,
    "avatar_url": String,
    "since": "2017-03-08 09:00:56 UTC",
    "commits": [{
      "url": String,
      "title": String,
      "created_at": "2017-03-08 09:00:56 UTC"
    },
    ...
  }
}
```

## Development

### Prerequisites

- Make
- Go 1.18+ (only for `import.go`)
  - `musl-cross` (`brew install FiloSottile/musl-cross/musl-cross`)

### Setup

Generate a [new GitHub Token](https://github.com/settings/tokens/new) (no `scope` is required).

```shell
⚡make dev
⚡nvim .envrc # add your GitHub Token
```

### Import

`import.go` imports all the repositories, commits, and commit authors from Hanami GitHub organization and stores them into `db/production.db`

To run the import logic locally:

```shell
⚡make run
```

To build the import logic for GitHub Actions:

```shell
⚡make build
```

## License

Check `LICENSE.txt` file
