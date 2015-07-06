class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show, :vote]
  before_action :load_post, only: [:update, :edit, :show, :vote, :destroy]

  include Votables

  def destroy
    if user_log_in? && user_authorized?
      @post.destroy
      redirect_to posts_url, notice: "notice. post deleted"
    elsif user_log_in?
      flash[:error] = "error. not the user added this post"
      render template: 'posts/show'
    else
      flash[:error] = "error. log-in please"
      redirect_to login_url
    end
  end

  def index
    @posts = Post.order('updated_at desc').preload(:comments, :votes, :categories)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save && @post.assign_categories
      redirect_to post_url(@post), notice: "notice. post added"
    else
      flash[:error] = "error. not saved"
      render action: "new"
    end
  end

  def edit
    unless user_authorized? && user_log_in?
      flash[:error] = "error. not the user added this post"
      render template: 'posts/show'
    end
  end

  def update
    if user_log_in? && user_authorized?
      if @post.update(post_params) && @post.assign_categories
        redirect_to post_url(@post), notice: "notice. post updated"
      else
        flash[:error] = "error. not updated"
        render action: "edit"
      end
    elsif user_log_in?
      flash[:error] = "error. not the user added this post"
      render template: 'posts/show'
    else
      flash[:error] = "error. log-in please"
      redirect_to login_url
    end
  end

  def vote
    if user_log_in? && request.post?
      @post.voted_by(current_user, params[:voted])
    else
      flash[:error] = "error. login needed to vote"
    end
    redirect_to post_url(@post)
  end

  private

  def load_post
    @post = Post.all.select do |post|
      post.to_param == params[:id]
    end.first
    unless @post
      flash[:error] = "slug error"
      redirect_to root_url
    end
  end

  def post_params
    params.require(:post).permit(:url, :title, :description, category_ids: [])
  end

  def user_authorized?
    current_user == @post.user
  end
end
