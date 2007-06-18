require File.dirname(__FILE__) + '/../test_helper'
require 'clientcdrs_controller'

# Re-raise errors caught by the controller.
class ClientcdrsController; def rescue_action(e) raise e end; end

class ClientcdrsControllerTest < Test::Unit::TestCase
  fixtures :clientcdrs

  def setup
    @controller = ClientcdrsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = clientcdrs(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:clientcdrs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:clientcdr)
    assert assigns(:clientcdr).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:clientcdr)
  end

  def test_create
    num_clientcdrs = Clientcdr.count

    post :create, :clientcdr => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_clientcdrs + 1, Clientcdr.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:clientcdr)
    assert assigns(:clientcdr).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Clientcdr.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Clientcdr.find(@first_id)
    }
  end
end
