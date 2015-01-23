require 'codeclimate-test-reporter'
require 'simplecov'

formatters = [SimpleCov::Formatter::HTMLFormatter]

formatters << CodeClimate::TestReporter::Formatter if ENV['CODECLIMATE_REPO_TOKEN']

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]

SimpleCov.start

require 'overloaded_methods'

RSpec.configure do |c|
  c.disable_monkey_patching!
end

class CalculatesFibonacci
  class << self
    extend OverloadedMethods
    overload_method :entry do |m|
      m.when{|which| which <= 1}.do{|which| which}
      m.default{|which|
        CalculatesFibonacci.entry(which-1) + CalculatesFibonacci.entry(which-2)
      }
    end
  end
end

RSpec.describe CalculatesFibonacci do
  it "should return 0 for 0" do
    expect(CalculatesFibonacci.entry(0)).to eq(0)
  end
  it "should return 1 for 1" do
    expect(CalculatesFibonacci.entry(1)).to eq(1)
  end
  it "should return 1 for 2" do
    expect(CalculatesFibonacci.entry(2)).to eq(1)
  end
  {3 => 2, 4 => 3, 5 => 5, 6 => 8}.each_pair {|which,value|
      it "should return #{value} for #{which}" do
        expect(CalculatesFibonacci.entry(which)).to eq(value)
      end
    }
end


class WithWhenDo
  extend OverloadedMethods

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

  overload_method :no_default do |m|
  end

  overload_method :default_returns_parameters do |m|
    m.default { |*params| params}
  end

end

class WithPatternDoes
  extend OverloadedMethods
  overload_method :hello_world do |m|
    m.pattern { true }.does {'hello, world'}
  end

  overload_method :return_params do |m|
    m.pattern { |param1, param2| true}.does {|param1, param2| [param1, param2]}
  end

  overload_method :even_odd do |m|
    m.pattern {|number| number % 2 == 0 }.does { :even }
    m.pattern {|number| number % 2 == 1 }.does { :odd }
  end

  overload_method :number_of_digits do |m|
    m.pattern {|number| number < 10}.does {1}
    m.pattern {|number| number< 100}.does {2}
    m.default { 'more than two digits is crazy talk'}
  end

  overload_method :no_default do |m|
  end

  overload_method :default_returns_parameters do |m|
    m.default { |*params| params}
  end

  overload_method :two_params_collected do |m|
    m.default { |param1, *params| [param1, params] }
  end


end




RSpec.describe OverloadedMethods do
  [WithWhenDo, WithPatternDoes].each {|klass|
    describe "#{klass.to_s}" do
      it "should run the first method if the first pattern passes" do
        expect(klass.new.even_odd(2)).to eq(:even)
      end
      it "should run the second method if the first pattern fails, second pattern passes" do
        expect(klass.new.even_odd(3)).to eq(:odd)
      end

      describe "when only a true pattern" do
        it "should add the method that you define" do
          expect(klass.new).to respond_to(:hello_world)
        end
        it "should call the block" do
          expect(klass.new.hello_world).to eq('hello, world')
        end
      end
      describe "when calling with parameters" do
        it "should pass the parameters to the block" do
          returns = klass.new.return_params 'corey', 'haines'
          expect(returns).to include('corey')
          expect(returns).to include('haines')
        end
        describe "when trying to collect different parts of the parameters into an array" do
          it "should parse out the desired parameters and put the rest into an array" do
            return1, others = klass.new.two_params_collected 1, 2, 3
            expect(return1).to eq(1)
            expect(others).to include(2)
            expect(others).to include(3)
          end
        end

      end
      describe "when calling with a pattern" do
        it "should run the first method if the first pattern passes" do
          expect(klass.new.even_odd(2)).to eq(:even)
        end
        it "should run the second method if the first pattern fails, second pattern passes" do
          expect(klass.new.even_odd(3)).to eq(:odd)
        end
      end

      describe "when using the default" do
        it "should execute the default if no predicate passes" do
          expect(klass.new.number_of_digits(176)).to eq('more than two digits is crazy talk')
        end
        it "should not crash if there is no default given" do
          expect(klass.new.no_default).to be_nil
        end
        it "should pass the parameters to the default method, as well" do
          returns = klass.new.default_returns_parameters 'Rachel', 'Davis'
          expect(returns).to include('Rachel')
          expect(returns).to include('Davis')
        end
      end
    end

    }


end
