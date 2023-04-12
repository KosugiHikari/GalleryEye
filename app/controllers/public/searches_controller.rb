class Public::SearchesController < ApplicationController
  
  def search
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
  end
  
end
