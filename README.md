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
    "commits_count": Integer
  },
  ...
  ]
}
```

## Development
### First
Create GitHub keys for data aggregation. You can do it [here](https://github.com/settings/applications/new).

After that you need to set `GITHUB_API_ID` and `GITHUB_API_KEY` env variables in `# in .env.development` file:

```
# in .env.development
GITHUB_API_ID="<id>"
GITHUB_API_KEY="<key>"
```

### Second
You need to create db table and call all migrations, for this run this commands
```
bundle exec hanami db create
bundle exec hanami db migrate
```

After that, you need to call data aggregation. For this just call `db/seed.rb` file:
```
bundle exec ruby db/seed.rb
```

**Attention:** this code may be work around 1h (on my local machine). Be sure that you have this time before the start.

## License

Check `LICENSE.txt` file
