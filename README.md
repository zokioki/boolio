# Boolio

[![Gem Version](https://badge.fury.io/rb/boolio.svg)](https://badge.fury.io/rb/boolio)

A Ruby interface to the [booleans.io](https://booleans.io) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "boolio"
```

Or install it yourself as:

    $ gem install boolio

## Usage

Creating a Boolio instance hits the booleans.io API to create a corresponding boolean:

```ruby
bool = Boolio.new val: true
# => #<Boolio:0x007fdcfa8f3548 @val=true, @id="1aa1f9c8-c65d-43c9-b8cb-ed171f0719bb">
```

Instantiating without a `val` argument will generate a random boolean value. This instance can now be used to interact your booleans. For example, to update your boolean's value, the API's `PUT` endpoint can be triggered by calling `#update`:

```ruby
bool.val = false
bool.update
```

Or,

```ruby
bool.update false
```

Already have an ID? Retrieving your booleans is simple:

```ruby
bool = Boolio.fetch("5b4851a0-0883-4cef-8651-59b2daf053da")
# => #<Boolio:0x007fdcfb3bb7a0 @val=true, @id="5b4851a0-0883-4cef-8651-59b2daf053da">
```

Invoking `#destroy!` removes your boolean from the booleans.io server, nullifies the instance's attributes, and freezes the instance:

```ruby
bool = Boolio.new val: false
# => #<Boolio:0x007fdcf99e8b98 @val=false, @id="b3f0a1fb-b74a-42b0-a950-cd57bd29a351">
bool.destroy!
# => #<Boolio:0x007fdcf99e8b98 @val=nil, @id=nil>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
