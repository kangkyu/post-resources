class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show, :vote]
  before_action :load_post, only: [:update, :edit, :show, :vote, :destroy]
  after_action :assign_categories, only: [:create, :update]

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
    @post.user_id = session[:user_id]
    if @post.save
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
      if @post.update(post_params)
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
    vote_votable(@post, params[:voted])

    respond_to do |format|
      format.html { redirect_to post_url(@post) }
      format.js {}
    end
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:url, :title, :description, category_ids: [])
  end

  def assign_categories
    id_array = @post.category_ids
    @post.hashtag_words.each do |word|
      word.downcase!
      id_array << Category.find_or_create_by(name: word).id
    end
    @post.category_ids = id_array.uniq
  end

  def user_authorized?
    current_user == @post.user
  end
end
