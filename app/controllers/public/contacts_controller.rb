class Public::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
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

end
