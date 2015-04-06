class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  def show
    @post = Post.find(params[:id])
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(params.require(:post).permit!)
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:error] = "error. not saved"
      render "new"
    end
  end
  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit!)
      redirect_to post_url(@post)
    else
      flash[:error] = "error. not updated"
      render "edit"
    end
  end
end
