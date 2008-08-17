$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module OverloadedMethods
  class BlockCollector
    def does &block
      capture &block
    end
    def do &block
      capture &block
    end
    def execute params
      @block.call *params
    end
    private
    def capture &block
      @block = block
    end
  end
  class PatternCollector
    def initialize
      @patterns = []
    end
    def pattern &block
      capture &block
    end
    def when &block
      capture &block
    end
    def execute params
      matching_pattern = @patterns.find{|predicate, block| predicate.call *params}
      return matching_pattern[1].execute(params) unless matching_pattern.nil?
      return @default.call(*params) unless @default.nil?
    end
    def default &block
      @default = block
    end
    private
    def capture &block
      b = BlockCollector.new
      @patterns << [block, b]
      b
    end
  end




  def self.included base
     base.extend ClassMethods
  end
  module ClassMethods
    def overload_method name
      pattern_collector = PatternCollector.new
      yield pattern_collector
      define_method name do |*params|
        pattern_collector.execute params
      end
    end
  end


end