class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :confirm, :edit, :update]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @posts = @user.posts.where(is_draft: :false).order(created_at: :desc).page(params[:page])
    @draft_post = @user.posts.where(is_draft: :true).order(created_at: :desc).page(params[:page])
    @name = params[:name]
  end

  def confirm
    @posts = @user.posts.where(is_draft: :true)
  end

  def edit
  end

  def update
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
    @name = params[:name]
  end

  private

  def user_params
    params.require(:user).permit(:name, :birthdate, :sex, :profile_image, :is_deleted, :introduction)
  end

  # 重複するコードをメソッド化
  def set_user
    @user = User.find(params[:id])
  end
end
