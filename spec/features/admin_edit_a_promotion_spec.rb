require 'rails_helper'

feature 'Admin edit a promotion' do
    scenario 'succesfully' do
        Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Cyber Monday'
        click_on 'Editar promoção'

        fill_in 'Nome', with: 'Cyber Monday'
        fill_in 'Descrição', with: 'Promoção de Cyber Monday'
        fill_in 'Código', with: 'CYBER15'
        fill_in 'Desconto', with: '20'
        fill_in 'Quantidade de cupons', with: '90'
        fill_in 'Data de término', with: '22/12/2033'
        click_on 'Finalizar edição'
        
        expect(current_path).to eq(promotion_path(Promotion.last))
        expect(page).to have_content('Cyber Monday')
        expect(page).to have_content('Promoção de Cyber Monday')
        expect(page).to have_content('CYBER15')
        expect(page).to have_content('20')
        expect(page).to have_content('90')
        expect(page).to have_content('22/12/2033')
    end

    #scenario 'and atributtes cannot be blanck' do
     #   Promotion.create!(name: 'Cyber Monday', coupon_quantity: '90',
      #                      description: 'Promoção de Cyber Monday', 
       #                     code: 'CYBER15', discount_rate: 15,
        #                    expiration_date: '22/12/2033')

        #visit root_path
        #click_on 'Promoções'
        #click_on 'Cyber Monday'
        #click_on 'Editar promoção'

        #fill_in 'Nome', with: ''
        #fill_in 'Descrição', with: ''
        #fill_in 'Código', with: ''
        #fill_in 'Desconto', with: ''
        #fill_in 'Quantidade de cupons', with: ''
        #fill_in 'Data de término', with: ''
        #click_on 'Finalizar edição'

        #expect(page).to have_content('Não foi possível editar a promoção')
    #end
end