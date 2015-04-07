class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :load_post, only: [:update, :edit, :show]
  def index
    @posts = Post.all
  end
  def show
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    if @post.save
      redirect_to post_url(@post), notice: "notice. post added"
    else
      flash[:error] = "error. not saved"
      render action: "new"
    end
  end
  def edit
    unless correct_user?
      flash[:error] = "error. not the user added this post"
      render template: 'posts/show'
    end
  end
  def update
    if correct_user? && @post.update(post_params)
      redirect_to post_url(@post), notice: "notice. post updated"
    else
      flash[:error] = "error. not updated"
      render action: "edit"
    end
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:url, :title, :description, category_ids: [])
  end
  def correct_user?
    current_user == @post.user
  end
end
