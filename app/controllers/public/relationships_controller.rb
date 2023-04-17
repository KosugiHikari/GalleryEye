class Public::RelationshipsController < ApplicationController
  before_action :set_user

  # フォローするとき
  def create
    current_user.follow(params[:user_id])
  end

  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
  end

  # フォロー一覧
  def followings
    @users = @user.followings
  end

  # フォロワー一覧
  def followers
    @users = @user.followers
  end

  private

  # 重複するコードをメソッド化
  def set_user
    @user = User.find(params[:user_id])
  end
end
