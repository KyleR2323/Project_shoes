class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(subtotal: 0, user_id: current_user.id)
    total_price = 0

    if @order.save
      session[:shopping_cart].each do |item|
        shoe = Shoe.find_by(id: item["id"])

        if shoe.present?
          quantity = item["quantity"]
          subtotal = shoe.price * quantity
          total_price += subtotal

          @order.order_items.create(
            quantity: quantity,
            price: shoe.price,
            shoe_id: shoe.id,
            tax: shoe.price * (current_user.province&.GST || 0 + current_user.province&.PST || 0 + current_user.province&.HST || 0)
          )
        end
      end

      @order.update(subtotal: total_price)


      # Clear shopping cart
      session[:shopping_cart] = nil

      redirect_to order_path(@order.id)
    else
      # Handle case where order creation fails
      Rails.logger.debug("Failed to save order: #{order.errors.full_messages}")
      redirect_to some_path, alert: "Failed to create order."
    end
  end


  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_path
  end

end
