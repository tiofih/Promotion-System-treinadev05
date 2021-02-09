require 'rails_helper'

feature 'Admin aproves a promotion' do
    scenario 'and must be signed in' do
        user = User.create!(email: 'joao@email.com', password: '123456')
        p = Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033', user: user)
        visit promotion_path(p)
        
        expect(current_path).to eq new_user_session_path
    end

    scenario 'must not be the promotion creator' do
        creator = User.create!(email: 'joao@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033', user: creator)
        other_user = User.create!(email: 'henrique@email.com', password: '123456')

        login_as creator, scope: :user
        visit promotion_path(promotion)

        expect(page).not_to have_link 'Aprovar Promoção'
    end

    scenario 'must be another user' do
        creator = User.create!(email: 'joao@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033', user: creator)
        other_user = User.create!(email: 'henrique@email.com', password: '123456')

        login_as other_user, scope: :user
        visit promotion_path(promotion)

        expect(page).to have_link 'Aprovar Promoção'
    end

    scenario 'succesfully' do
        creator = User.create!(email: 'joao@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033', user: creator)
        approval_user = User.create!(email: 'henrique@email.com', password: '123456')

        login_as approval_user, scope: :user
        visit promotion_path(promotion)
        click_on 'Aprovar Promoção'

        promotion.reload
        expect(current_path).to eq promotion_path(promotion)
        expect(promotion.approved?).to be_truthy
        expect(promotion.approver).to eq approval_user
        expect(page).to have_content 'Promoção aprovada'
    end
end