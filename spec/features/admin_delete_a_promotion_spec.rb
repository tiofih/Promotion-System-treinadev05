require 'rails_helper'

feature 'Admin delete a promotion' do
    scenario 'succesfully' do
        Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Cyber Monday'
        click_on 'Deletar promoção'

        expect(current_path).to eq(promotions_path)
        expect(Promotion.count).to eq 0
        #expect(page).to have_content('Promoção deletada com sucesso')
    end
end