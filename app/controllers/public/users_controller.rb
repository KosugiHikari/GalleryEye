class Public::UsersController < ApplicationController
  
  def index
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def edit
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :birtydate, :sex, :profiel_image, :is_deleted)
  end
  
end
