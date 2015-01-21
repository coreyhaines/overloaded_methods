module OverloadedMethods

  def overload_method name
    collector = FunctionDefinition.new
    yield collector
    define_method name do |*params|
      collector.execute params
    end
  end

  class Clause
    def self.match_all
      new ->*{true}
    end
    def self.with_predicate(predicate)
      new predicate
    end
    attr_reader :predicate
    def initialize(predicate)
      @predicate = predicate
    end
    def match?(*params)
      @predicate.call(*params)
    end
    def do &block
      @block = block
      self
    end
    def return value
      self.do {|*|value}
    end
    alias :does :do
    def call *params
      @block.call *params
    end
  end

  class FunctionDefinition
    def initialize
      @clauses = []
      @default = Clause.match_all.return(nil)
    end
    def when &predicate
      Clause.with_predicate(predicate).tap { |clause| @clauses << clause }
    end
    alias :pattern :when
    def execute params
      [*@clauses, @default]
        .find { |clause| clause.match? *params }
        .call(*params)
    end
    def default &block
      @default = Clause.match_all.do(&block)
    end
  end
end
