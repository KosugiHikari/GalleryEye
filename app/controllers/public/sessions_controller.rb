# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # 顧客のログイン処理が実行される前に退会管理用のカラムを確認し、退会済みだった場合、ログインせずにサインアップ画面に遷移する
  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if @user.valid_password?(params[:user][:password]) && @user.is_deleted == true
      flash[:notice] = "退会済みの為、再登録が必要です"
      redirect_to new_user_registration_path
    end
  end
end
