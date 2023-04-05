class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
    redirect_to root_path
    else
      render :new
    end
  end
  
  def index
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user.id)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:art_exhibition_name, :gallery_name, :start_date, :end_date, :admission, :address, :shooting_availability, :point, :body, :image)
  end
end
