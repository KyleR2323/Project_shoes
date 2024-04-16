class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :shoes, through: :order_items
  has_one :province, through: :user
end
