require "test_helper"

class LoginControllerTest < ActionController::TestCase

  def test_get_new
    get :new
    assert_response :success
  end

  def test_login_create
    user = users(:one)
    post :create, params: {
      login: { username: users(:one).username, password: "password" }
    }
    assert_equal user.id, session[:user_id]
  end

  def test_login_destroy
    session[:user_id] = users(:one).id
    delete :destroy
    assert_nil session[:user_id]
  end
end
