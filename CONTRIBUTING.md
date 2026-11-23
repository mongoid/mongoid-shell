# Contributing to Mongoid::Shell

Fork the project, create a topic branch, make your feature addition or bug fix with tests, add a line to [CHANGELOG.md](CHANGELOG.md), and open a pull request against `master`.

## Test

```sh
bundle install
bundle exec rake
```

`bundle exec rake` runs lint and specs on MRI Ruby 3.3 or newer, and only specs on older Ruby versions. Run `bundle exec rake lint` to check Ruby, Markdown, YAML, and spelling. Add reviewed project vocabulary to `.spellcheck.txt`, use one line per Markdown paragraph, and use title case for headings.

Set `MONGODB_PORT` to redirect the fixture sessions' local socket connection (default: `27017`). These tests render commands; they do not execute MongoDB shell tools or write to or drop databases.

CI collects SimpleCov coverage across the supported Ruby, Mongoid, and MongoDB matrix and combines parallel reports on Coveralls using GitHub's workflow token. Legacy Moped and modern driver paths run against their actual supported Mongoid versions, rather than being simulated in one job. To generate a local report, run `COVERAGE=true MONGOID_VERSION=9 bundle install` followed by `COVERAGE=true MONGOID_VERSION=9 bundle exec rake spec`. Reports are written to `coverage/`; a single Mongoid version cannot cover every version-specific path. Fresh-process entrypoint tests also collect coverage, including files loaded by Bundler before the main test suite starts.
