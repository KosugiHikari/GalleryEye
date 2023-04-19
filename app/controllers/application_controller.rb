class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # ユーザー登録に必要な情報追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :public
       root_path
    elsif resource_or_scope == :admin
       admin_session_path
    else
       root_path
    end
  end

end
