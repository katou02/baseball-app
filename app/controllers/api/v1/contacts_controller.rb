class Api::V1::ContactsController < ApiController
  protect_from_forgery
  
  def index
    @contact = Contact.new
  end

  def check
    contact = Contact.new(contact_params)
    if contact.valid?
      ContactMailer.send_email(contact).deliver
    else
      render json: { errors: contact.errors.keys.map { |key| [key, contact.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  private
  def contact_params
    params.permit(:name, :email, :content)
  end
end