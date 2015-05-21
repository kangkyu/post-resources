class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show, :vote]
  before_action :load_post, only: [:update, :edit, :show, :vote, :destroy]
  after_action :assign_categories, only: [:create, :update]

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "notice. post deleted"
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
    unless correct_user?(@post.user)
      flash[:error] = "error. not the user added this post"
      render template: 'posts/show'
    end
  end

  def update
    if correct_user?(@post.user) && @post.update(post_params)
      redirect_to post_url(@post), notice: "notice. post updated"
    else
      flash[:error] = "error. not updated"
      render action: "edit"
    end
  end

  def vote
    if !user_log_in?
      flash[:error] = "error. login needed to vote"
    elsif @post.votes.where(user: current_user).count != 0
      vote = @post.votes.find_by(user: current_user)
      vote.update(voted: params[:voted])
    else
      vote = @post.votes.build(voted: params[:voted], user: current_user)
      vote.save
    end
    redirect_to post_url(@post)
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
end
