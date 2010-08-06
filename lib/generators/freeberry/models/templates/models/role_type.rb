class RoleType < Freeberry::Models::RoleType
  # [:default, :redactor, :moderator, :admin]
  define_enum do |builder|
    builder.member :default,   :object => new("default")
    builder.member :redactor,  :object => new("redactor")
    builder.member :moderator, :object => new("moderator")
    builder.member :admin,     :object => new("admin")
  end
end
