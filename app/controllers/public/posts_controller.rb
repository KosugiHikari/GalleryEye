class Public::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_q, only: [:index, :search]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    # 投稿の新しい順
    @new_posts = Post.where(is_draft: false).new_post
    # 投稿の古い順
    @old_posts = Post.where(is_draft: false).old_post
    # いいねの多い順
    @like_posts = Post.where(is_draft: false).includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}

    @now = Post.where('start_date <= ?', Date.today).where('end_date >= ?', Date.today)
    @end = Post.where('end_date <= ?', Date.today)
    @soon = Post.where('start_date >= ?', Date.today)

    # 全タグ取得↓
    @tags = Post.tag_counts_on(:tags).order('count DESC')
    if @tag = params[:tag]
      # タグに紐付く投稿。tagged_withは絞り込み検索するメソッド。
      # クリックされたtag情報を取得し、tagged_with("タグ名")で検索↓
      @post = Post.tagged_with(params[:tag])
    end
  end

  def show
    params[:name]
    @name = params[:name]
    @comment = Comment.new
    # 投稿に紐付くタグの表示↓
    @tags = @post.tag_counts_on(:tags)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user.id)
  end

  def search
    @posts = @q.result(distinct: true)
    @name = params[:name]
  end

  private

  def post_params
    params.require(:post).permit(:art_exhibition_name, :gallery_name, :start_date, :end_date, :admission, :address, :shooting_availability, :point, :body, :post_image, :tag_list, :is_draft).merge(holding_area: params[:post][:holding_area].to_i)
  end

  # 重複するコードをメソッド化
  def set_post
    @post = Post.find(params[:id])
  end

  def set_q
    @q = Post.ransack(params[:q])
  end
end
