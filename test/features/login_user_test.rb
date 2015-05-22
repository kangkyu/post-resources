require "test_helper"

class LoginUserTest < Capybara::Rails::TestCase
  test "before login" do
    visit root_path

    assert_link "register"
    assert_link "login"
  end

  test "after login" do
    test_log_in
    visit root_path

    assert_link "profile"
    assert_link "logout"
  end

  test "log out" do
    test_log_in
    click_link "logout"

    assert_text "user logged out"
  end

  test "log in" do
    visit login_path
    fill_in "Username", with: users(:one).username
    fill_in "Password", with: 'password'
    click_button "Login"

    assert_text "user logged in"
  end
end
