# encoding: utf-8
module Freeberry
  class StructureType
    def initialize(value)
      @kind = value
    end
    attr_reader :kind
    
    def title
      I18n.t(@kind, :scope => [:manage, :structure, :kind])
    end
  end
end
