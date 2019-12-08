require "test_helper"

class ListPostsTest < Capybara::Rails::TestCase

  def test_view_posts_index
    visit root_path
    posts.each do |post|
      assert_content page, post.title
    end
  end

  def test_view_posts_show
    post = posts(:one)

    visit post_path(post)
    assert_content page, post.title
  end
end
