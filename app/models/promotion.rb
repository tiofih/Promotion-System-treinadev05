class Promotion < ApplicationRecord
  has_many :coupons
  belongs_to :user
  validates :name, :discount_rate, :code, :coupon_quantity, :expiration_date, presence: true
  # validates :discount_rate, :coupon_quantity, numericality: { greater_than: 0 }
  validates :code, uniqueness: true

  def generate_coupons!
    Coupon.transaction do
      coupons_array = []
      (1..coupon_quantity).each do |number|
        coupon_hash = { code: "#{code}-#{'%04d' % number}",
                        created_at: DateTime.now,
                        updated_at: DateTime.now }
        coupons_array << coupon_hash
      end
      coupons.insert_all!(coupons_array)
    end
  end
end
