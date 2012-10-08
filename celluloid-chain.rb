require 'celluloid'

module Celluloid
  class Chain
    class Call
      def initialize(method_name, args, block)
        @method_name = method_name
        @args = args
        @block = block
      end
      attr_reader :method_name, :args, :block
    end

    include Celluloid

    def initialize(target)
      @target = target
      @calls = []
      @running = false
    end

    def add(method_name, *args, &block)
      @calls << Call.new(method_name, args, block)
      unless @running
        process!
      end
    end

    def process
      while call = @calls.shift
        @running = true
        @target.send(call.method_name, *call.args, &call.block)
      end
      @running = false
    end
  end
end
