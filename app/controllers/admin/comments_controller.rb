class Admin::CommentsController < ApplicationController

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    flash.now[:notice] = 'コメントを削除しました'
  end

end
