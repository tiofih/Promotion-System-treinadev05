class DescriptionsController < ApplicationController
    def index
        @promotions = Promotion.all
    end
end