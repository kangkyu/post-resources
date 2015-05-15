require "test_helper"

class LoginUserTest < Capybara::Rails::TestCase
  test "before login" do
    visit root_path
    assert_content page, "register"
    assert_content page, "login"
  end

  test "after login" do
    visit login_path

    fill_in "Username", with: users(:one).username
    fill_in "Password", with: 'password'
    click_button "Login"

    visit root_path
    assert_content page, "profile"
    assert_content page, "logout"
  end
end
