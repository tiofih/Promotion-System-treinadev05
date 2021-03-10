require 'rails_helper'

feature 'Admin inactivate coupon' do
    scenario 'succesfully' do
        user = FactoryBot.create(:user)
        login_as(user, :scope => :user)
        promotion = create(:promotion, user: user)
        coupon = Coupon.create!(code: 'ABC0001', promotion: promotion)

        visit root_path
        click_on 'Promoções'
        click_on promotion.name
        click_on 'Inativar'

        expect(page).to have_content('ABC0001 (Inativo)')
        expect(promotion.coupons.reload.active.size).to eq 0
    end

    scenario 'does not view button' do
        user = User.create!(email: 'joao@email.com', password: '123456')
        login_as(user, :scope => :user)
        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                                  expiration_date: '22/12/2033', user: user) 
        inactive_coupon = Coupon.create!(code: 'ABC0001', promotion: promotion, 
                                status: :inactive)
        active_coupon = Coupon.create!(code: 'ABC0002', promotion: promotion, 
                                status: :active)

        visit root_path
        click_on 'Promoções'
        click_on promotion.name

        
        within("div#coupon-#{inactive_coupon.id}") do
            expect(page).not_to have_link 'Inativar'
        end
        within("div#coupon-#{active_coupon.id}") do
            expect(page).to have_link 'Inativar'
        end
    end
end