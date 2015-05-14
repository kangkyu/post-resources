class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show, :vote]
  before_action :load_post, only: [:update, :edit, :show, :vote]
  after_action :assign_categories, only: [:create, :update]

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

  def assign_categories
    id_array = @post.category_ids
    words = @post.description.split
    words.each do |word|
      if word != "#" && word.start_with?("#")
        category_name = word.slice(1..-1).gsub(/[[:punct:]]/, '')
        id_array << Category.find_or_create_by(name: category_name).id
      end
    end
    @post.category_ids = id_array.uniq
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:url, :title, :description, category_ids: [])
  end
end
