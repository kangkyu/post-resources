require 'test_helper'

class EditPostsTest < Capybara::Rails::TestCase

  def test_edit_post_button_same_user_show_page
    log_in
    post = posts(:two)
    post.update user: users(:one)
    visit post_path(post)

    assert_equal users(:one), post.user
    assert_link "edit post"
  end

  def test_no_edit_post_button_different_user_show_page
    log_in
    post = posts(:two)
    post.update user: users(:two)
    visit post_path(post)

    refute_equal users(:one), post.user
    refute_link "edit post"
  end

  def test_no_edit_page_without_login
    post = posts(:two)
    visit edit_post_path(post)
    assert_content "error. log-in please"
  end

  def test_no_edit_page_with_login_but_different_user
    log_in
    post = posts(:two)
    post.update user: users(:two)

    visit edit_post_path(post)
    assert_content "error. not the user added this post"
  end

  def test_no_edit_page_with_login_but_different_user
    log_in
    post = posts(:two)
    post.update user: users(:one)

    visit edit_post_path(post)
    assert_content "Edit Post"
    assert_field "Title"
  end

  def test_edit_post
    log_in
    post = posts(:two)
    post.update user: users(:one)
    visit edit_post_path(post)

    assert_equal "RubyTapas", post.title
    fill_in "Title", with: "Ruby Tapas"
    click_button "Update Post"
    assert_content "notice. post updated"

    assert_equal "Ruby Tapas", post.reload.title
  end

  def log_in
    visit login_path
    fill_in "Username", with: users(:one).username
    fill_in "Password", with: 'password'
    click_button "Login"
  end
end
