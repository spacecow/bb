class SalesController < ApplicationController
  load_and_authorize_resource

  def create
    @sale.created_at = Johan::DateTime.new params[:sale][:created_at] if params[:sale][:created_at]
    if @sale.save
      session[:preferred_unit] = @sale.unit 
      session[:preferred_date] = @sale.created_at 
      redirect_to @sale.familiar, notice:created(:sale)
    else
      if @sale.familiar.nil?
        @familiar = Familiar.new
        @hash = {}
        render 'familiars/index'
      else
        @familiar = @sale.familiar
        @hash = @familiar.regulated_sale_values_freq
        @interval_hash = @familiar.regulated_sale_values_freq_per_day
        render 'familiars/show' 
      end
    end
  end

  def update
    if @sale.update_attributes(params[:sale])
      redirect_to @sale.familiar, notice:updated(:sale)
    else
      render :edit
    end
  end

  def destroy
    familiar = @sale.familiar
    @sale.destroy
    redirect_to familiar, notice:deleted(:sale)
  end
end
