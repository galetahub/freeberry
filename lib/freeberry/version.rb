# encoding: utf-8
module Freeberry
  module Version
    MAJOR = 0
    MINOR = 2
    RELEASE = 7

    def self.dup
      "#{MAJOR}.#{MINOR}.#{RELEASE}"
    end
  end
end
