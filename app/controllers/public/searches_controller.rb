class Public::SearchesController < ApplicationController

  def search
    @users = User.search(params[:keyword]).page(params[:page]).per(10)
    @keyword = params[:keyword]
  end

end
