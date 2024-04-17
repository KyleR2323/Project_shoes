class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create

  end

  def destroy

  end

  def send_email

  end
end
