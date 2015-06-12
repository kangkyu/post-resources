class CommentsController < ApplicationController
  before_action :authenticate_user

  include Votables

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.build(comment_params.merge(user_id: current_user.id))
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

    respond_to do |format|
      format.html { redirect_to post_url(@comment.post) }
      format.js {}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
