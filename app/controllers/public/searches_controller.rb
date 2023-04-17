class Public::SearchesController < ApplicationController

  def search
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
  end

end
