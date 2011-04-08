# encoding: utf-8
module Freeberry
  module Version
    MAJOR = 0
    MINOR = 3
    RELEASE = 0

    def self.dup
      "#{MAJOR}.#{MINOR}.#{RELEASE}"
    end
  end
end
