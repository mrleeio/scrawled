# Scrawled

A simple blogging platform built with Ruby on Rails.

## Setup

Follow these steps to get the project up and running on your local machine:

### Prerequisites

- Install ruby version defined in the [.ruby-version](.ruby-version) file.
- PostgreSQL (latest)
- Redis (latest)

### Development

Clone the repository:

```
git clone git@github.com:mrleeio/scrawled.git
```

Setup your database:

```
bundle exec rails db:setup
```

Create the `master.key` file for decrypting credentials:

```
MASTER_KEY=

echo $MASTER_KEY > master.key
```

Start the web/worker processes:

```
gem install foreman

foreman start -f Procfile.dev
```