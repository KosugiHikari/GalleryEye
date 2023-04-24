class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @keyword = params[:keyword]
    @users = User.search(params[:keyword]).page(params[:page]).per(10)
  end

end
