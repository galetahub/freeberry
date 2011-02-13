require 'rails/generators'
require 'freeberry/utils'

module Freeberry
  class ManageScaffoldGenerator < Rails::Generators::NamedBase
    check_class_collision :suffix => "Controller"
    
    class_option :parent, :type => :string, :default => nil,
                          :desc => "Parent model"
    
    def self.source_root
      @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), "/templates"))
    end
    
    def create_controller_files
      template "#{generator_dir}/controller.rb", 
               File.join('app/controllers', manage_path, "#{controller_file_name}_controller.rb")
      
      template "#{generator_dir}/helper.rb",
               File.join('app/helpers', manage_path, "#{controller_file_name}_helper.rb")    
    end
    
    def create_tests_files
      template "#{generator_dir}/functional_test.rb",
               File.join('test/functional', manage_path, "#{controller_file_name}_controller_test.rb")
    end
    
    def create_views_files
      # model form
      template "#{generator_dir}/views/form.html.erb",
               File.join('app/views', manage_path, controller_file_name, "_form.html.erb")
      
      # search filter
      template "#{generator_dir}/views/model_filter.html.erb",
               File.join('app/views', manage_path, controller_file_name, "_model_filter.html.erb")
      
      # collection view partial
      template "#{generator_dir}/views/item.html.erb",
               File.join('app/views', manage_path, controller_file_name, "_#{singular_name}.html.erb")
      
      # other templates
      [:index, :new, :edit, :show].each do |action|
        template "#{generator_dir}/views/#{action}.html.erb",
               File.join('app/views', manage_path, controller_file_name, "#{action}.html.erb")
      end
    end
    
    protected
      
      def manage_path
        "manage"
      end
      
      def klass
        # First priority is the namespaced modek, e.g. User::Group
        @klass ||= begin
          namespaced_class = name.singularize
          namespaced_class.constantize
        rescue NameError
          nil
        end
        
        # Second priority the camelcased c, i.e. UserGroup
        @klass ||= begin
          camelcased_class = name.gsub('::', '').singularize
          camelcased_class.constantize
        rescue NameError
          nil
        end
        
        @klass ||= model_name.constantize
        
        @klass
      end
      
      def model
        @model ||= klass.new
      end
      
      def model_name
        @model_name ||= name.camelize
        @model_name
      end
      
      def controller_class_name
        @controller_class_name ||= name.pluralize.camelize
      end
      
      def controller_file_name
        @controller_file_name ||= file_name.pluralize
      end
      
      def generator_dir
        options[:parent] ? "multiplay" : "single"
      end
      
      def parent_class_name
        @parent_class_name ||= parent_singular_name.camelize
        @parent_class_name
      end
      
      def parent_singular_name
        @parent_singular_name ||= options[:parent].singularize
        @parent_singular_name
      end
      
      def translated_columns
        @translated_columns ||= klass.translated_attribute_names if klass.respond_to?(:translated_attribute_names)
        @translated_columns ||= []
      end
  end
end
