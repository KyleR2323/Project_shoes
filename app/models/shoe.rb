class Shoe < ApplicationRecord
  belongs_to :brand
  belongs_to :sale_price

  def self.ransackable_associations(auth_object = nil)
    ["brand", "sale_price"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["brand_id", "color", "created_at", "description", "gender", "id", "id_value", "material", "price", "quantity_available", "sale_price_id", "shoe_model", "shoe_type", "size", "updated_at"]
  end
end
