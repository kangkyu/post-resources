class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.build(params.require(:comment).permit(:body))
    comment.user_id = session[:user_id]
    if comment.save
      redirect_to @post, notice: "notice. comment added"
    else
      flash[:error] = "error. comment not saved"
      render template: 'posts/show'
    end
  end

  def vote
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if !user_log_in?
      flash[:error] = "error. login needed to vote"
    elsif @comment.votes.where(user: current_user).count != 0
      vote = @comment.votes.find_by(user: current_user)
      vote.update(voted: params[:voted])
    else
      vote = @comment.votes.build(voted: params[:voted], user: current_user)
      vote.save
    end
    redirect_to post_url(@comment.post)
  end
end
