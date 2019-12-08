require "test_helper"

class LoginUserTest < Capybara::Rails::TestCase

  def test_before_login
    visit root_path

    assert_link "register"
    assert_link "login"
  end

  def test_after_logout
    test_log_in
    visit root_path

    assert_link "profile"
    assert_link "logout"
  end

  def test_log_out
    test_log_in
    click_link "logout"

    assert_text "user logged out"
  end

  def test_log_in
    visit login_path
    fill_in "Username", with: users(:one).username
    fill_in "Password", with: 'password'
    click_button "Login"

    assert_text "user logged in"
  end
end
