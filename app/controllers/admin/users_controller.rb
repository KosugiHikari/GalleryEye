class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の編集が完了しました"
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
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
