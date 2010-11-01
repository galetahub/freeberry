module Freeberry
  module Version
    MAJOR = 0
    MINOR = 2
    RELEASE = 2

    def self.dup
      "#{MAJOR}.#{MINOR}.#{RELEASE}"
    end
  end
end
