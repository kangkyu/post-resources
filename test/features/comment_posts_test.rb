require "test_helper"

class CommentPostsTest < Capybara::Rails::TestCase
  # include ActionController::TemplateAssertions

  def setup
    test_log_in
  end

  test "add comments form on posts show page" do
    post = posts(:one)
    visit post_path(post)

    assert_button 'Add Comment'
  end

  test "submit creating a comment" do
    post = posts(:one)
    visit post_path(post)

    fill_in "Body", with: "this is a test comment."
    click_button 'Add Comment'

    assert_content page, "this is a test comment."
  end

  test "log in" do
    visit login_path
    fill_in "Username", with: users(:one).username
    fill_in "Password", with: 'password'
    click_button "Login"

    assert_text "user logged in"
  end
end