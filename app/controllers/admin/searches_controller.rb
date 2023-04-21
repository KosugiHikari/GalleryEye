class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @keyword = params[:keyword]
    if @model == "Post"
      @posts = Post.search(params[:keyword]).page(params[:page]).per(10)
    elsif @model == "User"
      @users = User.search(params[:keyword]).page(params[:page]).per(10)
    end
  end

end
