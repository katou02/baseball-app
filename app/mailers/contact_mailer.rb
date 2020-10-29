class ContactMailer < ApplicationMailer
  
  def send_email(contact)
    @contact = contact
    mail(
      to: ENV['EMAIL_CONTACT'],
      subject: 'メッセージが届きました') do |format|
      format.text
    end
  end
end
