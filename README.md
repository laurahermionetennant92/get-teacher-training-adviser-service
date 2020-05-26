# DFE-Digital Get Teacher Training Adviser Service
![Build and Deploy](https://github.com/DFE-Digital/get-teacher-training-adviser-service/workflows/Build%20and%20Deploy/badge.svg)

![Release to test](https://github.com/DFE-Digital/get-teacher-training-adviser-service/workflows/Release%20to%20test/badge.svg)

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=DFE-Digital_get-teacher-training-adviser-service&metric=alert_status)](https://sonarcloud.io/dashboard?id=DFE-Digital_get-teacher-training-adviser-service)

## Prerequisites

- Ruby 2.6.6
- NodeJS 12.16.x
- Yarn 1.12.x

## Setting up the app in development

1. Run `bundle install` to install the gem dependencies
2. Run `yarn` to install node dependencies
4. Run `bundle exec rails server` to launch the app on http://localhost:3000
5. (optional) Run `./bin/webpack-dev-server` in a separate shell for faster compilation of assets

## Whats included in this application?

- Rails 6.0 with Webpacker
- [GOV.UK Frontend](https://github.com/alphagov/govuk-frontend)
- RSpec
- Dotenv (managing environment variables)
- Dockerfile
- CI based on GitHub Actions
- Deployment utilising GovUK PAAS

## Running specs, linter(without auto correct) and annotate models and serializers
```
bundle exec rake
```

## Running specs
```
bundle exec rspec
```

## Linting

It's best to lint just your app directories and not those belonging to the framework, e.g.

```bash
bundle exec rubocop app config db lib spec Gemfile --format clang -a

or

bundle exec scss-lint app/webpacker/styles
```

You can automatically run the Ruby linter on commit for any changed files with 
the following pre-commit hook `.git/hooks/pre-commit`.

```bash
#!/bin/sh
if [ "x$SKIPLINT" == "x" ]; then
    exec bundle exec rubocop $(git diff --cached --name-only --diff-filter=ACM | egrep '\.rb|\.feature|\.rake' | grep -v 'db/schema.rb') Gemfile
fi
```

### Configuration

`HTTPAUTH_USERNAME` and `HTTPAUTH_PASSWORD` - setting both enables site wide password protection
