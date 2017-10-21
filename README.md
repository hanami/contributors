# Hanami contributors

Display all hanami contributors on the one page.

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
### First
Copy .env files
```
cp .env.development.sample .env.development && cp .env.test.sample .env.test
```

### Second
Create GitHub keys for data aggregation. You can do it [here](https://github.com/settings/applications/new).

After that you need to set `GITHUB_API_ID` and `GITHUB_API_KEY` env variables in `# in .env.development` file:

```
# in .env.development
GITHUB_API_ID="<id>"
GITHUB_API_KEY="<key>"
```

### Third
You need to create db table and call all migrations, for this run this commands
```
bundle exec hanami db prepare
```

After that, you need to call data aggregation. For this just call `db/seed.rb` file:
```
bundle exec ruby db/seed.rb
```

**Attention:** this code may be work around 1h (on my local machine). Be sure that you have this time before the start.

## License

Check `LICENSE.txt` file
