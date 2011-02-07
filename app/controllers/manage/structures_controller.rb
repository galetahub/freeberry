class Manage::StructuresController < Manage::BaseController
  inherit_resources
  
  before_filter :find_root, :only=>[:index]  
    
  defaults :route_prefix => 'manage'
  
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
  def move
    @structure = Structure.find(params[:id])
    @structure.move_by_direction(params[:direction])
    
    respond_with(@structure, :location => manage_structures_path)
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
