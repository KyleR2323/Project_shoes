class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :shoes, through: :order_items
  has_one :province, through: :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "id_value", "pst", "subtotal", "total_amount", "updated_at", "user_id"]
  end
end
