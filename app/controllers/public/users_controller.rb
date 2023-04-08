class Public::UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
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

  private

  def user_params
    params.require(:user).permit(:name, :birtydate, :sex, :profile_image, :is_deleted, :introduction)
  end

end
