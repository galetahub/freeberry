module Freeberry
  module Version
    MAJOR = 0
    MINOR = 1
    RELEASE = 8

    def self.dup
      "#{MAJOR}.#{MINOR}.#{RELEASE}"
    end
  end
end
