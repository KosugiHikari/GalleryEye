class Public::ContactsController < ApplicationController
  before_action :set_contact, only: [:back, :create]

  def new
    @contact = Contact.new
  end

  # 確認画面
  def confirm
    if params[:contact].nil?
      redirect_to new_contacts_path
    else
      set_contact
    end
  end

  # 入力内容に誤りがあった場合、入力内容を保持したまま前のページに戻る
  def back
    redirect_to new_contacts_path
  end

  def create
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to root_path, notice: 'お問い合わせを承りました。ご入力いただいたメールアドレス宛にお問い合わせ内容確認のメールを送信しておりますので、合わせてご確認ください。'
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
