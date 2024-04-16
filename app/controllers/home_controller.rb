class HomeController < ApplicationController
  def index
    @shoes = Shoe.page(params[:page])
  end

  def sale
    @shoes = Shoe.where.not(sale_price: nil).page(params[:page])
  end

  def new
    three_days = DateTime.now - 3.days
    shoes = Shoe.where("created_at > ? ", three_days).page(params[:page])
  end
end
