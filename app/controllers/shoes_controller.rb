class ShoesController < ApplicationController
  def index
    @shoes = case params[:filter]
    when "on_sale"
      Shoe.where(on_sale: true)
    when "new"
      Shoe.where("created_at >= ?", 3.days.ago)
    when "recently_updated"
      Shoe.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago)
    else
      Shoe.all
    end.page(params[:page]).per(12)
  end

  def show
    @shoe = Shoe.includes(:brand).find(params[:id])
  end

  def search
    @keywords = params[:keywords]
    @brand_id = params[:brand_id]

    @shoes = Shoe.includes(:brand)

    if @keywords.present?
      wildcard_search = "%#{@keywords}%"
      @shoes = @shoes.where("shoe_model LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)
    end

    if @brand_id.present?
      @shoes = @shoes.where(brand_id: @brand_id)
    end

    @shoes = @shoes.page(params[:page]).per(12)

  end
end
