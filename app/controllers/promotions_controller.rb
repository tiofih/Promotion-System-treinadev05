class PromotionsController < ApplicationController
    def index
        @promotions=Promotion.all
    end

    def show
        @promotion = Promotion.find(params[:id])
    end

    def new
        @promotion = Promotion.new
    end

    def create
        promotion_params = params.require(:promotion).permit(:name, :description, 
                                        :code, :discount_rate, 
                                        :coupon_quantity, :expiration_date)
        @promotion = Promotion.new(promotion_params)
        if @promotion.save
            redirect_to promotion_path(id: @promotion.id)
        else
            render 'new'
        end
    end
end
