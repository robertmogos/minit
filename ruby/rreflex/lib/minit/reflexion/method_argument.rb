require "minit/reflexion/typed_reff"
module Minit
  module Reflexion
    class MethodArgument < TypedReff
      attr_accessor :label
    end
  end
end