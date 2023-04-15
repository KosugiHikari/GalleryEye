class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.is_draft == false
      if @post.save(context: :publicize)
        redirect_to root_path
      else
        render :new
      end
    else
      if @post.is_draft == true
      @post.save
      redirect_to root_path
      else
        render :new
      end
    end
  end

  def index
    # 投稿の新しい順
    @new_posts = Post.where(is_draft: false).new_post
    # 投稿の古い順
    @old_posts = Post.where(is_draft: false).old_post
    # いいねの多い順
    @like_posts = Post.where(is_draft: false).includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}

    # 全タグ取得↓
    @tags = Post.tag_counts_on(:tags).order('count DESC')
    if @tag = params[:tag]
      # タグに紐付く投稿。tagged_withは絞り込み検索するメソッド。
      # クリックされたtag情報を取得し、tagged_with("タグ名")で検索↓
      @post = Post.tagged_with(params[:tag])
    end
  end

  def show
    @post = Post.find(params[:id])
    pp params[:name]
    @name = params[:name]
    @comment = Comment.new
    # 投稿に紐付くタグの表示↓
    @tags = @post.tag_counts_on(:tags)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:art_exhibition_name, :gallery_name, :start_date, :end_date, :admission, :address, :shooting_availability, :point, :body, :post_image, :tag_list, :is_draft)
  end
end
