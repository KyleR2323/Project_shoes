class CartController < ApplicationController
  def create
    logger.debug("Adding #{params[:id]} to cart with quantity #{params[:quantity]}")

    id = params[:id].to_i
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    shoe = Shoe.find_by(id: id)  # Find the shoe by its ID

    if shoe.nil?
      flash[:alert] = "Shoe not found"
      redirect_to root_path
      return
    end

    existing_item = session[:shopping_cart].find { |item| item["id"] == id }

    if existing_item
      existing_item["quantity"] += quantity
    else
      session[:shopping_cart] << { "id" => id, "quantity" => quantity, "shoe" => shoe }
    end

    flash[:notice] = "+ #{quantity} #{shoe.show_model}(s) added to cart. Check your Cart"
    redirect_to root_path
  end

  def destroy
    logger.debug("Removing #{params[:id]} from cart.")
    id = params[:id].to_i

    if (index = session[:shopping_cart].find_index { |item| item["id"] == id })
      session[:shopping_cart].delete_at(index)
    end

    redirect_to cart_path
  end

  def update_quantity
    id = params[:id].to_i
    quantity = params[:quantity].to_i

    existing_item = session[:shopping_cart].find { |item| item["id"] == id }

    return unless existing_item

    existing_item["quantity"] = quantity

    redirect_to cart_path
  end

  def show
    @cart = session[:shopping_cart]
  end
end

