require "test_helper"

class CommentPostsTest < ActionDispatch::IntegrationTest
  # include ActionController::TemplateAssertions

  def setup
    log_in
  end

  def test_add_comments_form_on_posts_show_page
    post = posts(:one)
    visit post_path(post)

    assert_button 'Add Comment'
  end

  def test_submit_creating_a_comment
    post = posts(:one)
    visit post_path(post)

    fill_in "Body", with: "this is a test comment."
    click_button 'Add Comment'

    assert_content page, "this is a test comment."
  end

  def test_log_in
    assert_text "user logged in"
  end

  def log_in
    visit login_path
    fill_in "Username", with: users(:one).username
    fill_in "Password", with: 'password'
    click_button "Login"
  end
end
