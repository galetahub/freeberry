class Manage::<%= controller_class_name %>Controller < Manage::BaseController
  inherit_resources
  defaults :route_prefix => 'manage'
  
  before_filter :make_filter, :only=>[:index]

  load_and_authorize_resource  
  
  def create
    create!{ manage_<%= plural_name %>_path }
  end
  
  def update
    update!{ manage_<%= plural_name %>_path }
  end
  
  def destroy
    destroy!{ manage_<%= plural_name %>_path }
  end
  
  protected
    
    def collection
      options = { :page => params[:page], :per_page => 20 }
      options.update @search.filter
      
      @<%= plural_name %> ||= (@<%= plural_name %> || end_of_association_chain).paginate(options)
    end
    
    def make_filter
      @search = Freeberry::ModelFilter.new(<%= class_name %>, :attributes=>[ <%= model.attributes.keys.map{ |a| ":#{a}" }.join(', ') %> ] )
      @search.update_attributes(params[:search])
    end
end
