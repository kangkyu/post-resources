class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.build(params.require(:comment).permit!)
    if comment.save
      redirect_to @post
    else
      flash[:error] = "error. comment not saved"
      render 'posts/show'
    end
  end
end