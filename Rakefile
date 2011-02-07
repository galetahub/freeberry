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
    gemspec.homepage = "https://github.com/galetahub/freeberry"
    gemspec.authors = ["Igor Galeta", "Pavlo Galeta"]
    gemspec.files = FileList["[A-Z]*", "{app,config,lib}/**/*"]
    gemspec.rubyforge_project = "freeberry"
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
