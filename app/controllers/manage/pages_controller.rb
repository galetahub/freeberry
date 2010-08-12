class Manage::PagesController < Manage::BaseController
  before_filter :find_structure
  
  respond_to :html, :xml
  
  cache_sweeper :page_sweeper, :only => [:create, :update, :destroy]
  
  # GET /manage/structures/1/page/edit
  def edit
    @page = @structure.page || @structure.build_page(:title=>@structure.title)
    
    respond_with(@page) do |format|
      format.html { render :action => (@page.new_record? ? 'new' : 'edit') }
    end
  end
  
  # POST /manage/structures/1/page
  def create
    @page = @structure.build_page(params[:page])
    @page.save
    
    respond_with(@page, :location => manage_structures_path)
  end
  
  # PUT /manage/structures/1/page
  def update
    @page = @structure.page
    @page.update_attributes(params[:page])
    
    respond_with(@page, :location => manage_structures_path)
  end
  
  protected
  
    def find_structure
      @structure = Structure.find(params[:structure_id])
    end
end
