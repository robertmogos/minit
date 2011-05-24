module Rreflex
  class Method
    attr_accessor :name,:arguments,:returnType
  
    def initialize(name,returnType)
      @name = name
      @arguments = []
      @returnType = returnType
    end
  end
end