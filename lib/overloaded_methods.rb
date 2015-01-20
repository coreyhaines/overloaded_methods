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
    def execute params
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
    end
    def when &predicate
      capture &predicate
    end
    alias :pattern :when
    def execute params
      matching_pattern = @clauses.find{|predicate, _| predicate.call *params}
      return matching_pattern[1].execute(params) unless matching_pattern.nil?
      return @default.call(*params) unless @default.nil?
    end
    def default &block
      @default = block
    end
    private
    def capture &predicate
      b = ClauseBody.new
      @clauses << [predicate, b]
      b
    end
  end
end
