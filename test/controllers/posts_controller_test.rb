require "test_helper"

class PostsControllerTest < ActionController::TestCase

  def test_get_index
    get :index
    assert_response :success
  end

  def test_post_create
    session[:user_id] = users(:one).id

    assert_difference 'Post.count' do
      post :create, post: posts(:one).attributes
       .merge(categories: [categories(:two), categories(:four)])
    end
  end
end
