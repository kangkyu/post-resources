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
end
