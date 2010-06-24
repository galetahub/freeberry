namespace :freeberry do
  task :setup do
    system("rails generate freeberry:base")
    system("rails generate freeberry:migration")
  end
end
