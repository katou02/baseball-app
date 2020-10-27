class ContactMailer < ApplicationMailer
  default to: ENV['EMAIL_CONTACT']

  def send_email(contact)
    @contact = contact
    mail(subject: 'メッセージが届きました') do |format|
      format.text
    end
  end
end
