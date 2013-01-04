class SalesController < ApplicationController
  load_and_authorize_resource

  def create
    if @sale.save
      session[:preferred_unit] = @sale.unit 
      redirect_to @sale.familiar, notice:created(:sale)
    else
      if @sale.familiar.nil?
        @familiar = Familiar.new
        @hash = {}
        render 'familiars/index'
      else
        @familiar = @sale.familiar
        @hash = @familiar.regulated_sale_values_freq
        render 'familiars/show' 
      end
    end
  end

  def destroy
    familiar = @sale.familiar
    @sale.destroy
    redirect_to familiar, notice:deleted(:sale)
  end
end
