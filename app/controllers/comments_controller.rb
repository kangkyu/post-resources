class CommentsController < ApplicationController
  before_action :authenticate_user
  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.build(params.require(:comment).permit(:body))
    if comment.save
      redirect_to @post
    else
      flash[:error] = "error. comment not saved"
      render template: 'posts/show'
    end
  end
end
