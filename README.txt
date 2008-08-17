= overloaded_methods

http://github.com/coreyhaines/overloaded_methods

== DESCRIPTION:

overloaded_methods was inspired by erlang pattern matching. Basically, the idea is that you can specify a method and several code blocks based on aspects of the parameters. Here's an example:

overload_method :even_odd do |m|
  m.when {|number| number % 2 == 0 }.do { :even }
  m.when {|number| number % 2 == 1 }.do { :odd }
end

You can then call even_odd(2) and get :even, even_odd(3) gives you :odd.

the specs have more examples.

Special thanks to Jim Weirich for suggesting some great improvements in the syntax.

There is an alternate syntax with pattern/does
overload_method :even_odd do |m|
  m.pattern {|number| number % 2 == 0 }.does { :even }
  m.pattern {|number| number % 2 == 1 }.does { :odd }
end
However, this syntax may or may not be deprecated in favor of the when/do syntax.

== FEATURES/PROBLEMS:

* FIX (list of features or problems)

== SYNOPSIS:

The following is from the specs, just some examples of how to use it.

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

== REQUIREMENTS:

Ruby

== INSTALL:

working on gemspec for github.

== LICENSE:

(The MIT License)

Copyright (c) 2008 Corey Haines

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.