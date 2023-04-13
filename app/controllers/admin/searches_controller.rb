class Admin::SearchesController < ApplicationController

  def search
    @model = params[:model]
    @keyword = params[:keyword]
    if @model == "Post"
      @posts = Post.search(params[:keyword])
    elsif @model == "User"
      @users = User.search(params[:keyword])
    end
  end

end
