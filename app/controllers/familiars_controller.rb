class FamiliarsController < ApplicationController
  load_and_authorize_resource

  def show
    @sale = @familiar.sales.new(value:0,unit:'Mandrake')
    @hash = @familiar.regulated_sale_values_freq
  end

  def index
    @familiar = Familiar.new
    @sale = Sale.new(unit:'Mandrake')
    respond_to do |f|
      f.html{ @familiars = @familiars.sort_by(&:median).reverse }
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

  def update
    if @familiar.update_attributes(params[:familiar])
      begin
        @familiar.remote_image_url = @familiar.static_image_url
        @familiar.save
      rescue OpenURI::HTTPError
        flash[:alert] = "Page does not exist!"
      end
      redirect_to familiars_path
    end
  end
end
