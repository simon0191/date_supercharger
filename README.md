# Date Supercharger

A nice shortcut for date queries.

Date Supercharger adds `_between`,`_between_inclusive`,`_after`, `_after_or_at`, `_before` and `_before_or_at` methods to every date/datetime field of Active Record models.

[![Build Status](https://travis-ci.org/simon0191/date_supercharger.svg)](https://travis-ci.org/simon0191/date_supercharger)
[![Code Climate](https://codeclimate.com/github/simon0191/date_supercharger/badges/gpa.svg)](https://codeclimate.com/github/simon0191/date_supercharger)
[![Test Coverage](https://codeclimate.com/github/simon0191/date_supercharger/badges/coverage.svg)](https://codeclimate.com/github/simon0191/date_supercharger/coverage)
[![Gem Version](https://badge.fury.io/rb/date_supercharger.svg)](http://badge.fury.io/rb/date_supercharger)

## Usage

### between

```ruby
Visit.created_at_between(from,to)
```

instead of

```ruby
Visit.where("created_at >= ? AND created_at < ?",from,to)
```

### between_inclusive
```ruby
Visit.created_at_between_inclusive(from,to)
```

instead of

```ruby
Visit.where("created_at >= ? AND created_at <= ?",from,to)
```

### after/before

```ruby
Visit.created_at_after(some_date)
```

instead of

```ruby
Visit.where("created_at > ?",some_date)
```

### after_or_at/before_or_at

```ruby
Visit.created_at_before_or_at(some_date)
```

instead of

```ruby
Visit.where("created_at <= ?",some_date)
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
