require 'test_helper'

class RegisterUserTest < ActionDispatch::IntegrationTest

  def setup
    host! "example.com"
  end

  def test_get_open
    get '/'
    assert_response :success
  end

  def test_post_register
    get '/register'
    assert_response :success

    post_via_redirect '/users', user: {"username"=>"username", "password"=>"password", "password_confirmation"=>"password"}
    assert_equal "notice. registered and logged in", flash[:notice]
  end

  def test_login_user
    get '/login'
    assert_response :success

    get "/users/#{users(:two).id}/edit"
    assert_response :redirect
    assert_equal "error. log-in please", flash[:error]

    post_via_redirect '/login', login: {username: users(:one).username, password: "password"}
    assert_equal '/', path
    assert_equal "notice. user logged in", flash[:notice]
  end

  def test_edit_register
    post_via_redirect '/login', login: {username: users(:one).username, password: "password"}

    get "/users/#{users(:one).id}"
    assert_response :success

    get "/users/#{users(:one).id}/edit"
    assert_response :success

    patch_via_redirect "/users/#{users(:one).id}", user: {"username"=>"username"}
    assert_equal "/users/#{users(:one).id}",path
    assert_equal "notice. user updated", flash[:notice]
  end

  def test_edit_other_user
    post_via_redirect '/login', login: {username: users(:one).username, password: "password"}

    get "/users/#{users(:two).id}/edit"
    assert_response :redirect
    assert_equal "error. not the current user", flash[:error]

    patch_via_redirect "/users/#{users(:two).id}", user: {"username"=>"username"}
    assert_response :success # ?
    assert_equal "error. not the current user", flash[:error]
  end
end
