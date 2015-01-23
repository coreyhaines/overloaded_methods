# Overloaded Methods

[![Build Status](https://travis-ci.org/coreyhaines/overloaded_methods.svg?branch=master)](https://travis-ci.org/coreyhaines/overloaded_methods)
[![Gem Version](https://badge.fury.io/rb/overloaded_methods.svg)](http://badge.fury.io/rb/overloaded_methods)
[![Code Climate](https://codeclimate.com/github/coreyhaines/overloaded_methods/badges/gpa.svg)](https://codeclimate.com/github/coreyhaines/overloaded_methods)
[![Test Coverage](https://codeclimate.com/github/coreyhaines/overloaded_methods/badges/coverage.svg)](https://codeclimate.com/github/coreyhaines/overloaded_methods)

[http://github.com/coreyhaines/overloaded_methods](http://github.com/coreyhaines/overloaded_methods)

## Description

overloaded_methods was inspired by erlang pattern matching. Basically, the idea is that you can specify a method and several code blocks based on aspects of the parameters. Here's an example:

```ruby
overload_method :even_odd do |m|
  m.when {|number| number % 2 == 0 }.do { :even }
  m.when {|number| number % 2 == 1 }.do { :odd }
end
```

You can then call ```even_odd(2)``` and get ```:even```, ```even_odd(3)``` gives you ```:odd```.

the specs have more examples.

Special thanks to Jim Weirich for suggesting some great improvements in the syntax.

There is an alternate syntax with pattern/does

```ruby
overload_method :even_odd do |m|
  m.pattern {|number| number % 2 == 0 }.does { :even }
  m.pattern {|number| number % 2 == 1 }.does { :odd }
end
```

However, this syntax may or may not be deprecated in favor of the when/do syntax.

Here's an example of Fibonacci calculation:

```ruby
class CalculatesFibonacci

  class << self
    include OverloadedMethods
    overload_method :entry do |m|
      m.when{|which| which <= 1}.do{|which| which}
      m.default{|which|
          CalculatesFibonacci.entry(which-1) + CalculatesFibonacci.entry(which-2)
        }
    end
  end
end
```


## Synopsis

Here are some examples of how to use it from [the specs](spec/overloaded_methods_spec.rb).

```ruby
class WithWhenDo
  include OverloadedMethods

  overload_method :even_odd do |m|
    m.when {|number| number % 2 == 0 }.do { :even }
    m.when {|number| number % 2 == 1 }.do { :odd }
  end

  overload_method :hello_world do |m|
    m.when { true }.do {'hello, world'}
  end

  overload_method :return_params do |m|
    m.when { |param1, param2| true}.do {|param1, param2| [param1, param2]}
  end

  overload_method :two_params_collected do |m|
    m.default { |param1, *params| [param1, params] }
  end

  overload_method :number_of_digits do |m|
    m.when {|number| number < 10}.do {1}
    m.when {|number| number< 100}.do {2}
    m.default { 'more than two digits is crazy talk'}
  end

  overload_method :default_returns_parameters do |m|
    m.default { |*params| params}
  end

end
```

## Requirements

Ruby

## Install

```gem install overloaded_methods```

or, if using Bundler,

```gem 'overloaded_methods'```

## Do you use this

Please [let me know](mailto:coreyhaines@gmail.com)

## License

See [License.txt](License.txt)

## Monads

Monads
