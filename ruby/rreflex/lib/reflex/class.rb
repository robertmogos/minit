module Rreflex
  class Class
    attr_accessor :name, :methods
    def initialize(name)
      @name = name
      @methods = []
    end
  end
end