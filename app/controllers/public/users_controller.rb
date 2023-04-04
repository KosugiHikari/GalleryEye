class Public::UsersController < ApplicationController
  
  def index
  
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :birtydate, :sex, :profiel_image, :is_deleted)
  end
  
end
