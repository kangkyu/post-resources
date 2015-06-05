class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.build(comment_params.merge(user_id: session[:user_id]))
    if comment.save
      redirect_to @post, notice: "notice. comment added"
    else
      flash[:error] = "error. comment not saved"
      redirect_to @post
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    vote_votable(@comment, params[:voted])
    redirect_to post_url(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
