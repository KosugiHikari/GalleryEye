class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params)
    post.save
    redirect_to 'posts_path'
  end
  
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  private
  
  def post_params
    params.require(:post).permit(:art_exhibition_name, :gallery_name, :start_date, :end_date, :admission, :address, :shooting_availability, :point, :body)
  end
end
