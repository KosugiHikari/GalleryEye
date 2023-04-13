class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    # 投稿ボタンを押下したとき
    if params[:post]
      # (context: :publicize):バリデーションをある状況では実行して、ある状況では実行しない場合に使用する
      # publicizeというcontextが指定されている時に、バリデーションを適用する
      # 今回は下書きの際にはバリデーションは不要のため
      if @post.save(context: :publicize)
      redirect_to post_path(@post), notice: "レビューを投稿しました！"
      else
        render :new, alert: "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください。"
      end
    # 下書きボタンを押下したとき
    else
      if @post.update(is_draft: true)
        redirect_to user_path(current_user), notice: "レビューを下書き保存しました！"
      else
        render :new, alert: "保存できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください。"
      end
    end
  end

  def index
    if params[:new_post]
      @posts = Post.new_post
    elsif params[:old_post]
      @posts = Post.old_post
    elsif params[:like_many]
      @posts = Post.like_many
    elsif params[:like_few]
      @posts = Post.like_few
    else
      @posts = Post.all
    end

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
    @comment = Comment.new
    # 投稿に紐付くタグの表示↓
    @tags = @post.tag_counts_on(:tags)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    # ①下書きレシピの更新（公開）の場合
    if params[:publicize_draft]
      @post.attributes = post_params.merge(is_draft: false)
      if @post.save(context: :publicize)
        redirect_to post_path(@post.id), notice: "下書きのレビューを公開しました！"
      else
        @post.is_draft = true
        render :edit, alert: "レビューを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end

    # ②公開済みレシピの更新の場合
    elsif params[:update_post]
      @post.attributes = post_params
      if @post.save(context: :publicize)
        redirect_to post_path(@post.id), notice: "レビューを更新しました！"
      else
        render :edit, alert: "レビューを更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end

    # ③下書きレシピの更新（非公開）の場合
    else
      if @post.update(post_params)
        redirect_to post_path(@post.id), notice: "下書きのレビューを更新しました！"
      else
        render :edit, alert: "レビューを更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
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
