class FamiliarsController < ApplicationController
  load_and_authorize_resource

  def show
    date = session[:preferred_date] || Date.today
    @sale = @familiar.sales.new(value:0,unit:'Mandrake',created_at:date)
    @hash = @familiar.regulated_sale_values_freq
  
    #sales = @familiar.sales.order(:created_at)
    #interval = Johan::Date.interval sales.map(&:created_at) 
    #@interval_hash = {}
    #interval.each{|date| @interval_hash[date] = Johan::Math.median(sales.select{|sale| sale.created_at < date.end_of_day}.last(10).map(&:regulated_value))}
  end

  def index
    @familiar = Familiar.new
    date = session[:preferred_date] || Date.today
    @sale = Sale.new(unit:'Mandrake', created_at:date)
    @sort = params[:sort] || 'max_damage'
    respond_to do |f|
      f.html
      #f.html{ @familiars = @familiars.sort_by(&:median).reverse }
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
        if params[:focus] == 'image'
          @familiar.remote_image_url = @familiar.static_image_url 
        elsif params[:focus] == 'stats'
          stats = Wiki.max_stats(@familiar.name)
          @familiar.maxhp = stats.shift
          @familiar.maxatk = stats.shift
          @familiar.maxdef = stats.shift
          @familiar.maxwis = stats.shift
          @familiar.maxagi = stats.shift
        elsif params[:focus] == 'skills'
          skill_infos = Wiki.skill_infos(@familiar.name)
          skill_infos.each do |info|
            skill = Skill.find_or_create_by_name(info[0]) 
            skill.description = info[1]
            skill.kind = info[2]
            skill.modifier = info[3]
            skill.status = info[4]
            skill.target = info[5]
            skill.save 
            begin
              @familiar.skills << skill
            rescue ActiveRecord::RecordInvalid
            end
          end 
        end
        @familiar.save
      rescue OpenURI::HTTPError
        flash[:alert] = "Page does not exist!"
      end
      redirect_to familiars_path
    end
  end
end
