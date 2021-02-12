require 'rails_helper'

feature 'Admin search a promotion' do
    scenario 'succesfully' do
        user = User.create!(email: 'joao@email.com', password: '123456')
        login_as(user, :scope => :user)
        Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033', user: user)
        Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033', user: user)

        visit root_path
        click_on 'Promoções'
        fill_in 'Busca', with: 'Cyber'
        click_on 'Pesquisar'

        expect(current_path).to eq search_path
        expect(page).to have_content('Cyber Monday')
        expect(page).to have_content('Promoção de Cyber Monday')
        expect(page).to have_content('CYBER15')
        expect(page).to have_content('15')
        expect(page).to have_content('90')
        expect(page).to have_content('22/12/2033')
        expect(page).not_to have_content('Natal')
    end

    scenario 'return error if promotion not found' do
        user = User.create!(email: 'joao@email.com', password: '123456')
        login_as(user, :scope => :user)
        Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033', user: user)

        visit root_path
        click_on 'Promoções'
        fill_in 'Busca', with: 'Natal'
        click_on 'Pesquisar'

        expect(page).to have_content('Nenhuma promoção encontrada')
    end
end