def insert_user
  # TurnOff Authorization system
  Authorization.ignore_access_control(true)
  
  # Path to words
  Haddock::Password.diction = Rails.root.join("config", "words")
  
  # User
  User.truncate_table
  Role.truncate_table
  password = Haddock::Password.generate
  
  admin = User.new(:name=>'Administrator', :email=>'bugs@brainberry.com.ua',
                   :password=>password, :password_confirmation=>password)
  admin.login = 'admin'
  admin.skip_confirmation!
  admin.save!
  admin.roles.create(:role_type => RoleType.admin)

  puts "Admin account: email: #{admin.email}, :password: #{admin.password}"
end

def insert_structures
  Structure.truncate_table
  
  main_page = Structure.create!(:title => "Главная страница", :slug => "main-page", :structure_type => StructureType.main, :parent => nil)
  #Structure.create!(:title => "Трансляции", :slug => "broadcasts", :structure_type => StructureType.broadcasts, :parent => main_page)
  #Structure.create!(:title => "Прямые репортажи", :slug => "posts", :structure_type => StructureType.posts, :parent => main_page)
end

insert_user
insert_structures
