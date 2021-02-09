require 'rails_helper'

RSpec.describe PromotionApproval, type: :model do
  describe '#valid?' do
    describe 'differente_user' do
      it 'is different' do
        creator = User.create!(email: 'joao@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033', user: creator)
        approval_user = User.create!(email: 'henrique@email.com', password: '123456')

        approval = PromotionApproval.new(promotion: promotion, user: approval_user)

        result = approval.valid?

        expect(result).to eq true
      end

      it 'is the same' do
        creator = User.create!(email: 'joao@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033', user: creator)

        approval = PromotionApproval.new(promotion: promotion, user: creator)

        result = approval.valid?

        expect(result).to eq false
      end

      it 'has no promotion or user' do
        approval = PromotionApproval.new()

        result = approval.valid?

        expect(result).to eq false
      end
    end
  end
end
