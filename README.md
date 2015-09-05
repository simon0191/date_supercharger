# Date Supercharger

A nice shortcut for date queries.

`date_supercharger` adds `_after`, `_after_or_at`, `_before` and `_before_or_at` methods to every date/datetime field of Active Record models.

[![Build Status](https://travis-ci.org/simon0191/date_supercharger.svg)](https://travis-ci.org/simon0191/date_supercharger)
[![Code Climate](https://codeclimate.com/github/simon0191/date_supercharger/badges/gpa.svg)](https://codeclimate.com/github/simon0191/date_supercharger)

## Usage

```ruby
Visit.created_at_after(DateTime.now)
```

instead of

```ruby
Visit.where("created_at > ?",DateTime.now)
```

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'date_supercharger'
```

And then execute:

```sh
bundle
```

## History

View the [changelog](https://github.com/simon0191/date_supercharger/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/simon0191/date_supercharger/issues)
- Fix bugs and [submit pull requests](https://github.com/simon0191/date_supercharger/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
