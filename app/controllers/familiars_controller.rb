class FamiliarsController < ApplicationController
  load_and_authorize_resource

  def show
    @sale = @familiar.sales.new(value:0,unit:'Hearts Blood')
    @hash = @familiar.regulated_sale_values_freq
  end

  def index
    @familiar = Familiar.new
    @sale = Sale.new
    respond_to do |f|
      f.html
      f.json{render json:@familiars.tokens(params[:q])}
    end  
  end

  def create
    if @familiar.save
      redirect_to familiars_path, notice:created(:familiar)
    else
      render :index
    end
  end
end
