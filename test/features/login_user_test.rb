require "test_helper"

class LoginUserTest < ActionDispatch::IntegrationTest

  def test_before_login
    visit root_path

    assert_link "register"
    assert_link "login"
  end

  def test_after_login
    log_in
    visit root_path

    assert_link "profile"
    assert_link "logout"
  end

  def test_log_out
    log_in
    click_link "logout"

    assert_text "user logged out"
  end

  def test_log_in
    log_in
    assert_text "user logged in"
  end

  def log_in
    visit login_path
    fill_in "Username", with: users(:one).username
    fill_in "Password", with: 'password'
    click_button "Login"
  end
end
