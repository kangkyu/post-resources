require "test_helper"

class ListPostsTest < Capybara::Rails::TestCase

  test "view posts index" do
    visit root_path
    posts.each do |post|
      assert_content page, post.title
    end
  end

  test "view posts show" do
    post = posts(:one)

    visit post_path(post)
    assert_content page, post.title
  end

end