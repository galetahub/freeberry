# encoding: utf-8
module Freeberry
  class RoleType
    def initialize(code)
      @code = code.to_sym
    end
    attr_reader :code
    
    def title
      I18n.t(@code, :scope => [:manage, :role, :kind])
    end  
  end
end
