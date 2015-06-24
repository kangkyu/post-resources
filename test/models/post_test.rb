require "test_helper"

class PostTest < ActiveSupport::TestCase

  def post_without_title
    @post ||= Post.new
  end

  def post
    @post ||= Post.new(title: "post")
  end

  def test_valid_without_title
    refute post_without_title.valid?
  end

  def test_valid
    assert post.valid?
  end

  def test_hashtag_words
    post.description = "#word"
    assert_equal ["word"], post.hashtag_words

    post.description = "A #free, once–weekly e-mail round-up of #Ruby #news..."
    assert_equal ["free", "Ruby", "news"], post.hashtag_words
  end

  def test_valid_with_unique_url
    post = Post.create!(title: "post", url: "example.com")

    another_post = Post.new(title: "post", url: "http://example.com")
    refute another_post.valid?

    another_post = Post.new(title: "post", url: "http://www.example.com")
    refute another_post.valid?

    another_post = Post.new(title: "post", url: "www.example.com")
    refute another_post.valid?

    another_post = Post.new(title: "post", url: "http://example.com/")
    refute another_post.valid?, "we don't need '/' at the end"
  end
end
