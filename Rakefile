# encoding: utf-8
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.join(File.dirname(__FILE__), 'lib', 'freeberry', 'version')

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the freeberry plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the freeberry plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Freeberry'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "freeberry"
    gemspec.version = Freeberry::Version.dup
    gemspec.summary = "Rails CRM System"
    gemspec.description = "Freeberry is a Brainberry CRM System"
    gemspec.email = "galeta.igor@gmail.com"
    gemspec.homepage = "git://github.com/galetahub/freeberry.git"
    gemspec.authors = ["Igor Galeta", "Pavlo Galeta"]
    gemspec.files = FileList["[A-Z]*", "{app,config,lib}/**/*"]
    gemspec.rubyforge_project = "freeberry"
    
    gemspec.add_dependency('warden', '>= 0.10.7')
    gemspec.add_dependency('devise', '>= 1.1.1')
    gemspec.add_dependency('paperclip', '>= 2.3.3')
    gemspec.add_dependency('nokogiri', '>= 1.4.3.1')
    gemspec.add_dependency('declarative_authorization', '>= 0.5')
    gemspec.add_dependency('inherited_resources', '>= 1.1.2')
    gemspec.add_dependency('haddock', '>= 0.2.2')
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
