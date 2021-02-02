class Promotion < ApplicationRecord
  has_many :coupons
  validates :name, :discount_rate, :code, :coupon_quantity, :expiration_date, presence: true
  # validates :discount_rate, :coupon_quantity, numericality: { greater_than: 0 }
  validates :code, uniqueness: true
end
