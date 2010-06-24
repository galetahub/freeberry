class Manage::AssetsController < Manage::BaseController
  skip_before_filter :verify_authenticity_token, :only=>[:create, :destroy]
  
  before_filter :find_klass, :only=>[:create]
  before_filter :find_asset, :only=>[:destroy]
  
  # POST /manage/assets.xml
  def create
    @asset ||= @klass.new(params[:asset])
    
  	@asset.assetable_type = params[:assetable_type]
		@asset.assetable_id = params[:assetable_id] || 0
		@asset.guid = params[:guid]
  	@asset.data = params[:data_file]
  	@asset.user = current_user
    
    if @asset.save
      render :xml => @asset.to_xml
    else
      render :xml => @asset.errors, :status => :unprocessable_entity
    end
  end
  
  # DELETE /manage/assets/1
  def destroy
    @asset.destroy
    
    respond_to do |format|
      format.html { head :ok }
      format.xml { head :ok }
    end
  end
  
  private
    def find_asset
      @asset = Asset.find(params[:id])  
    end
    
    def find_klass
      c_names = []
      c_values = []
      
      unless params[:assetable_id].blank?
        c_names << "assetable_id = ?"
        c_values << params[:assetable_id].to_i
        
        c_names << "assetable_type = ?"
        c_values << params[:assetable_type]
      else
        c_names << "guid = ?"
        c_values << params[:guid]
      end
      
      @klass = params[:klass].blank? ? Asset : params[:klass].classify.constantize
      
      if params[:collection].blank?
        @asset = @klass.find(:first, :conditions=>[c_names.join(' AND ')] + c_values)
      end
    end
end
