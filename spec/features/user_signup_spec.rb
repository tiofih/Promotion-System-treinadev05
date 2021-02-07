require 'rails_helper'

feature 'User sign up' do
    scenario 'succesfully' do
        visit root_path
        click_on 'Entrar'
        click_on 'Criar Conta'
        fill_in 'E-mail', with: 'joao@email.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Sign up'

        expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    end
end