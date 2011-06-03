module Minit
  module Reflexion
    class TypedReff
      attr_accessor :type,:name, :annotations
      def initialize(type)
        @type = type
      end
    end
  end
end