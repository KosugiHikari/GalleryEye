class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts.page(params[:page]).per(10)
    else
      @posts = Post.all.page(params[:page]).per(10)
    end
  end

  def show
    # 投稿に紐付くタグの表示↓
    @tags = @post.tag_counts_on(:tags)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "レビュー内容を編集しました"
      redirect_to admin_post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿の削除が完了しました"
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:art_exhibition_name, :gallery_name, :start_date, :end_date, :admission, :address, :shooting_availability, :point, :body, :post_image, :tag_list, :is_draft, :holding_area)
  end

  # 重複するコードをメソッド化
  def set_post
    @post = Post.find(params[:id])
  end

end
