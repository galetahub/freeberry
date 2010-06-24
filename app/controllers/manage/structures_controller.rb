class Manage::StructuresController < Manage::BaseController
  inherit_resources
  
  before_filter :find_root, :only=>[:index]  
    
  respond_to :html, :xml, :json
  defaults :route_prefix => 'manage'
  
  filter_access_to :move, :require => :update
  
  cache_sweeper :structure_sweeper, :only=>[:create, :update, :destroy, :move]
  
  def create
    create!{ manage_structures_path }
  end
  
  def update
    update!{ manage_structures_path }
  end
  
  def destroy
    destroy!{ manage_structures_path }
  end
  
  # POST /manage/structures/1/move
  # POST /manage/structures/1/move.js
  def move
    @structure = Structure.find(params[:id])
    
    respond_to do |format|
    	if @structure.move_by_direction(params[:direction])
        format.html { redirect_to manage_structures_path }
        format.xml { head :ok }
        format.js { head :ok }
      else     	
        format.html { render :action => "new" }
        format.xml { render :xml => @structure.errors, :status => :unprocessable_entity }
        format.js { head :unprocessable_entity }
      end
    end
  end
  
  protected
  
    def find_root
      @structure ||= Structure.with_kind(StructureType.main).with_depth(0).find(:first)
      @structure
    end
    
    def collection
      @structures ||= end_of_association_chain.with_depth(1).find(:all)
    end
end
