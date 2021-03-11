class PromotionMailer < ApplicationMailer
    def notify_approval
        @promotion = Promotion.find(params[:promotion_id])
    end
end