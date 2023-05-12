class Public::ContactsController < ApplicationController
  before_action :set_contact, only: [:confirm, :back, :create]

  def new
    @contact = Contact.new
  end

  # 確認画面
  def confirm
    if @contact.invalid?
      render :new
    end
  end

  # 入力内容に誤りがあった場合、入力内容を保持したまま前のページに戻る
  def back
    render :new
  end

  def create
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to root_path, notice: 'お問い合わせ内容を送信しました'
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end

  # 重複するコードをメソッド化
  def set_contact
    @contact = Contact.new(contact_params)
  end
end
