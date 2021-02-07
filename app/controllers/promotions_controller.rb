class PromotionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  def new
    @promotion = Promotion.new
  end

  def create
    promotion_params = params.require(:promotion)
                            .permit(:name, :code, :discount_rate, :description,
                                    :coupon_quantity, :expiration_date)
    @promotion = Promotion.new(promotion_params)
    @promotion.user = current_user

    if @promotion.save
      redirect_to promotion_path(id: @promotion.id)
    else
      render 'new'
    end
  end

  def edit
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update!(promotion_params)
      redirect_to promotion_path(promotion_params)
    else
      render 'edit'
    end
  end

  def destroy
    @promotion = Promotion.find(params[:id])
    @promotion.destroy

    redirect_to promotions_path
  end

  def generate_coupons
    @promotion = Promotion.find(params[:id])
    @promotion.generate_coupons!
    redirect_to @promotion, notice: t('.success')
  end

  private

  def promotion_params
    params.require(:promotion).permit(:name, :description,
                                      :code, :discount_rate,
                                      :coupon_quantity, :expiration_date)
  end
end
