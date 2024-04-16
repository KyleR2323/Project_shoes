class Brand < ApplicationRecord
  has_many :shoes
  validates :brand_name, presence: true, uniqueness: true
end
