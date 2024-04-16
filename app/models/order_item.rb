class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :shoe

  validates :quantity, numericality: { greater_than_or_equal_to: 1}
  validates :price, presence: true, numericality: true
end
