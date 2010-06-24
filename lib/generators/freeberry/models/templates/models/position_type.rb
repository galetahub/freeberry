class PositionType < Freeberry::PositionType
  # [:none, :menu, :bottom]
  define_enum do |builder|
    builder.member :default,  :object => new("default")
    builder.member :menu,     :object => new("menu")
    builder.member :bottom,   :object => new("bottom")
  end
end
