module Minit
  module Reflexion
    class Method
      attr_accessor :name,:arguments,:returnType
  
      def initialize(name,returnType)
        @name = name
        @arguments = []
        @returnType = returnType
      end
    end
  end
end