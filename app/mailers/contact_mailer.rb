class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: @contact.email, bcc: ENV["GMAIL_USERNAME"], subject: "お問い合わせについて【自動送信】"
  end

  def send_mail(contact)
    @contact = contact
    mail to: ENV["GMAIL_USERNAME"], subject: "問い合わせがありました"
  end
end
