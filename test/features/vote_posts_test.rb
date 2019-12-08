require 'test_helper'

class VotePostsTest < Capybara::Rails::TestCase

  def setup
    log_in
  end

  def test_upvote_show_page
    post = posts(:one)
    visit post_path(post)
    assert_equal "0", find(id: "post_#{post.id}_vote").text
    find_link(class: 'vote-up-post').click
    assert_equal "1", find(id: "post_#{post.id}_vote").text
  end

  def test_downvote_show_page
    post = posts(:two)
    visit post_path(post)
    assert_equal "0", find(id: "post_#{post.id}_vote").text
    find_link(class: 'vote-down-post').click
    assert_equal "-1", find(id: "post_#{post.id}_vote").text
  end

  def log_in
    visit login_path
    fill_in "Username", with: users(:one).username
    fill_in "Password", with: 'password'
    click_button "Login"
  end
end
