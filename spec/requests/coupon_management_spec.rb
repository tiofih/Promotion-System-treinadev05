require 'rails_helper'

describe 'Coupon management' do
    context 'GET coupon' do
        it 'should render coupon information' do
            user = User.create!(email: 'joao@email.com', password: '123456')
            login_as(user, :scope => :user)
            promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: '1',
                            description: 'Promoção de Cyber Monday', 
                            code: 'CYBER15', discount_rate: 15,
                            expiration_date: '22/12/2033', user: user)
            promotion.generate_coupons!
            coupon = promotion.coupons.last

            get "/api/v1/coupons/#{coupon.code}"
            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(200)
            expect(json_response[:status]).to eq('active')
            expect(json_response[:promotion][:discount_rate]).to eq('15.0')
            expect(json_response[:code]).to eq(coupon.code)
            #expect(json_response[:expiration_date]).to eq('22/12/2033')
        end

        it 'should return 404 if coupon does not exist' do
            get '/api/v1/coupons/blablabla'

            expect(response).to have_http_status :not_found
        end
    end
end