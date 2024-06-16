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

### Based UUID

This project generates “double-clickable”, URL-friendly UUIDs with optional prefixes:

```
user_763j02ryxh8dbs56mgcjqrmmgt #=> e61c802c-7bb1-4357-929a-9064af8a521a
bpo_12dm1qresn83st62reqdw7f7cv  #=> 226d037c-3b35-40f3-a30b-0ebb78779d9b
```

This functionality is provided by the [based_uuid](https://github.com/pch/based_uuid) gem.

#### Usage

Add the following line to your model class:

```
class BlogPost < ApplicationRecord
  has_based_uuid prefix: :bpo
end

post = BlogPost.last
post.based_uuid                #=> bpo_12dm1qresn83st62reqdw7f7cv
post.based_uuid(prefix: false) #=> 12dm1qresn83st62reqdw7f7cv

post.based_uuid_with_prefix
post.based_uuid_without_prefix
```

#### Lookup

BasedUUID includes a find_by_based_uuid model method to look up records:

```
BlogPost.find_by_based_uuid("bpo_12dm1qresn83st62reqdw7f7cv")

# or without the prefix:
BlogPost.find_by_based_uuid("12dm1qresn83st62reqdw7f7cv")

# there’s also the bang version:
BlogPost.find_by_based_uuid!("12dm1qresn83st62reqdw7f7cv")
```