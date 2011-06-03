module Minit
  module Reflexion
    class Class
      attr_accessor :name, :methods
      def initialize(name)
        @name = name
        @methods = []
      end
    
      def injectionInitializer
        return methods[0]
      end
    end
  end
end