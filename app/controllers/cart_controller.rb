class CartController < ApplicationController
  def index
    @cart = Shoe.find(session[:shopping_cart].keys)
  end

  def create
    id = params[:id].to_i
    session[:shopping_cart] ||= {}

    unless session[:shopping_cart].key?(id)
      session[:shopping_cart][id] = 1
      shoe = Shoe.find(id)
      flash[:notes] = "+ #{shoe.shoe_model} added to cart."
    end

    redirect_to root_path
  end

  def update
    id = params[:id].to_i
    quantity = params[:quantity].to_i

    if quantity < 1
      session[:shopping_cart].delete(id)
    else
      session[:shopping_cart][id] = quantity
    end

    redirect_to cart_index_path
  end

  def destroy
    id = params[:id].to_i
    shoe = Shoe.find(id)
    session[:shopping_cart].delete(id)
    flash[:notice] = "- #{shoe.shoe_model} removed from cart."
    redirect_to root_path
  end

  def checkout
    if user_signed_in?
      order = current_user.orders.create(
        subtotal: params[:subtotal],
        pst: params[:pst],
        gst: params[:gst],
        hst: params[:hst],
        total: params[:total],
        status: "paid"
      )

      if order.valid?
        session[:shopping_cart].each do |id, quantity|
          shoe = Shoe.find(id)
          price = shoe.sale_price.present? ? shoe.sale_price : shoe.price
          order.deliveries.create(
            quantity: quantity,
            item_price: item_price
          )
        end

        session[:shopping_cart].clear
        flash[:notice] = "Order Completed!"
        redirect_to root_path
      else
        flash[:alert] = "Order creation failed."
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = "You must be signed in to checkout."
      redirect_to new_user_session_path
    end
  end
end
