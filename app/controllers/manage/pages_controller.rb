class Manage::PagesController < Manage::BaseController
  before_filter :find_structure
  
  cache_sweeper :page_sweeper, :only=>[:create, :update, :destroy]
  
  # GET /manage/structures/1/page/edit
  def edit
    @page = @structure.page || @structure.build_page(:title=>@structure.title)
    
    respond_to do |format|
      format.html { render :action=>(@page.new_record? ? 'new' : 'edit') }
      format.xml { render :xml=>@page }
    end
  end
  
  # POST /manage/structures/1/page
  # POST /manage/structures/1/page.xml
  def create
    @page = @structure.build_page(params[:page])
    
    respond_to do |format|
    	if @page.valid? && @page.save
        flash[:success] = I18n.t('flash.manage.pages.create.success')
        
        format.html { redirect_to manage_structures_path }
        format.xml { head :ok }
      else
      	flash.now[:failure] = I18n.t('flash.manage.pages.create.failure')
      	
        format.html { render :action => "new" }
        format.xml { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /manage/structures/1/page
  # PUT /manage/structures/1/page.xml
  def update
    respond_to do |format|
    	if @structure.page.update_attributes(params[:page])
        flash[:success] = I18n.t('flash.manage.pages.update.success')
        
        format.html { redirect_to manage_structures_path }
        format.xml { head :ok }
      else
      	flash.now[:failure] = I18n.t('flash.manage.pages.update.failure')
      	
        format.html { render :action => "edit" }
        format.xml { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
    def find_structure
      @structure = Structure.find(params[:structure_id])
    end
end
