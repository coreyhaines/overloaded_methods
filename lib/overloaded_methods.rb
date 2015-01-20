module OverloadedMethods

  def overload_method name
    collector = FunctionDefinition.new
    yield collector
    define_method name do |*params|
      collector.execute params
    end
  end

  class ClauseBody
    def do &block
      capture &block
    end
    alias :does :do
    def call *params
      @block.call *params
    end
    private
    def capture &block
      @block = block
    end
  end

  class FunctionDefinition
    def initialize
      @clauses = []
      @default = [nil, lambda { |*| nil }]
    end
    def when &predicate
      capture &predicate
    end
    alias :pattern :when
    def execute params
      @clauses.find(->{@default}) {|predicate, _| predicate.call *params}.last.call(*params)
    end
    def default &block
      @default = [nil,block]
    end
    private
    def capture &predicate
      b = ClauseBody.new
      @clauses << [predicate, b]
      b
    end
  end
end
