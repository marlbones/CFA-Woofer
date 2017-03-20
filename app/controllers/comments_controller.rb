class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:content))
    redirect_to :back
    # @comment = Comment.new(post_id: params[:post_id])
  end
end
