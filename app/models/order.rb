class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :shoes, through: :order_items
  has_one :province, through: :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "id_value", "pst", "subtotal", "total_amount", "updated_at", "user_id"]
  end

  def gst
    province&.GST || 0
  end

  def pst
    province.PST || 0
  end

  def hst
    province.HST || 0
  end

  def save_payment_id(payment_id)
    update(payment_id:)
  end

  def mark_as_paid

  end

  def line_item_for_stripe

  end
end
