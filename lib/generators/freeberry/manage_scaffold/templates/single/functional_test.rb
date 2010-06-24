require 'test_helper'

class Manage::<%= controller_class_name %>ControllerTest < ActionController::TestCase
  
  def setup
    @admin = users(:admin)
  end

  test "index" do
    get :index, nil, {:user_id=>@admin.id}
    
    assert_response :success
    assert_not_nil assigns(:<%= plural_name %>)
  end
  
  test "new" do
    get :new, nil, {:user_id=>@admin.id}
    
    assert_response :success
    assert_not_nil assigns(:<%= singular_name %>)
    assert assigns(:<%= singular_name %>).new_record?
  end
  
  test "should_create_<%= singular_name %>" do
    assert_difference('<%= model_name %>.count') do
      post :create, {:<%= singular_name %> => { :title => '<%= model_name %> test title'} }, 
                    {:user_id=>@admin.id}
    end
    
    assert assigns(:<%= singular_name %>).valid?
    assert_equal assigns(:<%= singular_name %>).title, '<%= model_name %> test title'
    
    assert_redirected_to manage_<%= plural_name %>_path
  end
  
  test "should_error_create_<%= singular_name %>" do
    assert_no_difference('<%= model_name %>.count') do
      post :create, {:<%= singular_name %> => { :title => nil} }, 
                    {:user_id=>@admin.id}
    end
    
    assert !assigns(:<%= singular_name %>).valid?
    assert !assigns(:<%= singular_name %>).errors.empty?
    assert assigns(:<%= singular_name %>).errors.on(:title)
    
    assert_response :success
  end
  
  test "should_update_<%= singular_name %>" do
    <%= singular_name %> = <%= model_name %>.create(:title=>'<%= model_name %> test title')
    
    assert_no_difference('<%= model_name %>.count') do
      put :update, {:id=><%= singular_name %>.id, :<%= singular_name %> => { 
                    :title => '<%= model_name %> test title updated'} }, 
                    {:user_id=>@admin.id}
    end
    
    assert assigns(:<%= singular_name %>).valid?
    assert_equal assigns(:<%= singular_name %>).title, '<%= model_name %> test title updated'
    
    assert_redirected_to manage_<%= plural_name %>_path
  end
  
  test "should_error_update_<%= singular_name %>" do
    <%= singular_name %> = <%= model_name %>.create(:title=>'<%= model_name %> test title')
    
    assert_no_difference('<%= model_name %>.count') do
      put :update, {:id=><%= singular_name %>.id, :<%= singular_name %> => { :title =>nil} }, 
                    {:user_id=>@admin.id}
    end
    
    assert !assigns(:<%= singular_name %>).valid?
    assert !assigns(:<%= singular_name %>).errors.empty?
    assert assigns(:<%= singular_name %>).errors.on(:title)
    
    assert_response :success
  end
  
  test "should_destroy_<%= singular_name %>" do
    <%= singular_name %> = <%= model_name %>.create(:title=>'<%= model_name %> test title')
    
    assert_difference('<%= model_name %>.count', -1) do
      delete :destroy, {:id=><%= singular_name %>.id}, {:user_id=>@admin.id}
    end
    
    assert_redirected_to manage_<%= plural_name %>_path
    
    assert_raise(ActiveRecord::RecordNotFound) {
      <%= model_name %>.find(<%= singular_name %>.id)
    }
  end
  
  test "should_redirect_to_login" do
    get :index
    
    assert_redirected_to login_path
  end
end
