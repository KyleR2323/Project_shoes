class ContactController < ApplicationController
  def show
    @contact = Contact.all.first
  end
end
