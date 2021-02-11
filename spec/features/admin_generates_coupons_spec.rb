require 'rails_helper'

feature 'Admin generates coupons' do
  scenario 'of a promotion' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    login_as(user, :scope => :user)
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Gerar cupons'

    expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).to have_content('NATAL10-0001')
    expect(page).to have_content('NATAL10-0002')
    expect(page).to have_content('NATAL10-0100')
    expect(page).not_to have_content('NATAL10-0101')
  end

  scenario 'button deactivate if cupons are created' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    login_as(user, :scope => :user)
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                                  expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Gerar cupons'

    expect(page).not_to have_content('Gerar cupons')
  end

  #TODO: Implementar 
  xscenario 'button deactivate if promotion is not approved' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    login_as(user, :scope => :user)
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                                  expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Gerar cupons'

    expect(page).not_to have_content('Gerar cupons')
  end

  scenario 'not more than 9999' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    login_as(user, :scope => :user)
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 10000,
                                  expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Gerar cupons'

    expect(page).to have_content('Quantidade de cupons inválida')
  end

  scenario 'not minus than 1' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    login_as(user, :scope => :user)
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 0,
                                  expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Gerar cupons'

    expect(page).to have_content('Quantidade de cupons inválida')
  end
end
