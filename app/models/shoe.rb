class Shoe < ApplicationRecord
  validates :shoe_type, :price, :shoe_model, :size, :gender, :material, :quantity_available, presence: true

  belongs_to :brand
  belongs_to :sale_price

  def self.ransackable_associations(auth_object = nil)
    ["brand", "sale_price"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["brand_id", "color", "created_at", "description", "gender", "id", "id_value", "material", "price", "quantity_available", "sale_price_id", "shoe_model", "on_sale", "shoe_type", "size", "updated_at"]
  end

  has_one_attached :image
end
