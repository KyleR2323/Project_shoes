class AboutController < ApplicationController
  def show
    @about = About.all.first
  end
end
