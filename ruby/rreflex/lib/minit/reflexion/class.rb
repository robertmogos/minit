module Minit
  module Reflexion
    class Class
      attr_accessor :name, :methods, :header_file
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