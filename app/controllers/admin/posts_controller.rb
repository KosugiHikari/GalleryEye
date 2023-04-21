class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts.page(params[:page]).per(10)
    else
      @posts = Post.all.page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿の削除が完了しました"
    redirect_to admin_posts_path
  end

end
