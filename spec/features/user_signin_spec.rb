require 'rails_helper'

feature 'User sign in' do
    scenario 'succesfully' do
        user = User.create!(email: 'joao@email.com', password: '123456')

        visit root_path
        click_on 'Entrar'
        within('form') do
            fill_in 'E-mail', with: user.email
            fill_in 'Senha', with: '123456'
            click_on 'Entrar'
        end
        
        expect(page).to have_content user.email
        expect(page).to have_content 'Login efetuado com sucesso'
        expect(page).to have_link 'Sair'
        expect(page).not_to have_link 'Entrar'
    end

    scenario 'and logout' do
        user = User.create!(email: 'joao@email.com', password: '123456')

        visit root_path
        click_on 'Entrar'
        within('form') do
            fill_in 'E-mail', with: user.email
            fill_in 'Senha', with: '123456'
            click_on 'Entrar'
        end

        click_on 'Sair'

        expect(page).not_to have_content user.email
        expect(page).not_to have_content 'Login efetuado com sucesso'
        expect(page).not_to have_link 'Sair'
        expect(page).to have_link 'Entrar'
    end
end