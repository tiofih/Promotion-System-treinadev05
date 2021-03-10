FactoryBot.define do
  factory :promotion do
    name { 'Natal' }
    description { 'Promoção de Natal' }
    code { 'NATAL10' }
    discount_rate { 10 }
    coupon_quantity { 1 }
    expiration_date { 1.days.from_now }
  end
end