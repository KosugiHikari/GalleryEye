class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_id, only: [:create, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    unless @comment.save
      render 'error'
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    flash.now[:notice] = 'コメントを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def set_post_id
    @post = Post.find(params[:post_id])
  end

end
