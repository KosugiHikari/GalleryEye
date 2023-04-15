class Public::SearchesController < ApplicationController

  def search
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    params[:name]
    @name = params[:name]
  end

end
