class AboutController < ApplicationController
  def show
    @contact = Contact.all.first
  end
end
