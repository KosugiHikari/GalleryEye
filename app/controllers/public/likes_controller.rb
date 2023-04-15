class Public::LikesController < ApplicationController

  def create
    pp params[:name]
    @name = params[:name]
    @post = Post.find(params[:post_id])
    @post_like = current_user.likes.new(post_id: @post.id)
    @post_like.save!
  end

  def destroy
    pp params[:name]
    @name = params[:name]
    @post = Post.find(params[:post_id])
    @post_like = current_user.likes.find_by(post_id: @post.id)
    @post_like.delete
  end

end