class Public::TagsController < ApplicationController

  def index
    pp params[:name]
    @name = params[:name]
    if @tag = params[:tag]
      # タグに紐付く投稿。tagged_withは絞り込み検索するメソッド。
      # クリックされたtag情報を取得し、tagged_with("タグ名")で検索↓
      @post = Post.tagged_with(params[:tag])
    end
  end

end
