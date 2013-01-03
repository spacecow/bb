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
        render 'familiars/show' 
      end
    end
  end
end
