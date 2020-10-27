class ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def check
    @contact = Contact.new(contact_params)
    if @contact.valid?
      render :action => 'check'
    else
      render :action => 'index'
    end
  end

  def done
    @contact = Contact.new(contact_params)
    if params[:back]
      render :action => 'index'
    else
      MessageMailer.received_email(@contact).deliver_now
      render :action => 'done'
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
