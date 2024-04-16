class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  belongs_to :province

  validates :email, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "encrypted_password", "first_name", "id", "id_value", "last_name", "province_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
