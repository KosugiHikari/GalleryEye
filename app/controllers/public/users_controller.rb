class Public::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.where(is_draft: :false)
  end

  def confirm
    @user = User.find(params[:id])
    @posts = @user.posts.where(is_draft: :true)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def leave_check
    @user = current_user
  end

  def leave
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理が完了しました。ご利用ありがとうございました。"
    redirect_to root_path
  end

  def likes
    @user = User.find(params[:id])
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  private

  def user_params
    params.require(:user).permit(:name, :birthdate, :sex, :profile_image, :is_deleted, :introduction)
  end

end
