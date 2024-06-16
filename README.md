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

## Documentation

Details about the development of Scrawled that are useful to know about in advance.

### Default to UUIDv7 primary keys

Using UUIDs for primary keys offers many benefits, but there are some downsides to consider. The most widely-used UUIDv4 is fully random, which is ideal for minimizing the risk of collision. However, random IDs as primary keys do not index and sort efficiently, leading to index bloat and performance issues.

There is a new standard that addresses this problem by including a UNIX timestamp in the initial bits: UUIDv7.

Ruby 3.3.x introduced support for creating UUIDv7 using `SecureRandom.uuid_v7` or `Random.uuid_v7`.

This project is configured to generate UUIDv7 primary keys by default.