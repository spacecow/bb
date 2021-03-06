require 'assert'

class FamiliarPresenter < BasePresenter
  presents :familiar

  def actions
    h.content_tag :span, class:'actions' do
      h.link_to(h.t(:edit), h.edit_familiar_path(familiar)) +" Update("+
      h.link_to(h.pl(:image,1), h.familiar_path(familiar, focus: :image), method: :put) +" "+
      h.link_to(h.pl(:stats), h.familiar_path(familiar, focus: :stats), method: :put) +" "+
      h.link_to(h.pl(:skill), h.familiar_path(familiar, focus: :skills), method: :put) +")"
    end
  end

  def familiars(familiars, tag, sort, len)
    assert_include [:div,:ul], tag
    if tag == :div
      h.content_tag :div, class:'familiars' do
        h.render 'familiars/familiars', familiars:familiars, sort:sort, len:len if familiars.present?
      end
    elsif tag == :ul
      if sort == 'median'
        hash = familiars.group_by{|e| e.median len}
        h.content_tag :ul, class:'familiars' do
          hash.keys.sort.reverse.map do |median|
            "<li class='median'>#{median}</li>" +
            h.render(hash[median],len:len)
          end.join.html_safe
        end
      else
        arr = familiars.sort_by(&sort.to_sym).reverse
        h.content_tag :ul, class:'familiars' do
          h.render arr, len:len
        end
      end
    end
  end

  def form
    h.content_tag :div, class:'form' do
      h.render('familiars/form', familiar:familiar)
    end
  end

  def image(tag,version=nil)
    h.content_tag tag, class:"image #{version}" do
      h.image_tag familiar.image_url(version)
    end
  end

  def max_damage
    arr = familiar.familiars_skills.select{|e| e.kind == 'Attack' }
    h.content_tag :div, class:%w(max damage).join(' ') do
      "Max damage: #{arr.map(&:max_damage).join(', ')}" if arr.present?
    end
  end

  def median(len)
    date = familiar.last_sale_created_at
    h.content_tag :div, class:'median' do
      "Median: " +
      familiar.median(len).to_s + " (" +
      (date ? h.time_ago_in_words(date)+" ago" : "no data") + ")"
    end
  end

  def name
    h.content_tag :div, class:'name' do
      h.link_to familiar.name, familiar
    end
  end

  def new
    h.render 'familiars/new', familiar:Familiar.new
  end

  def new_sale(sale)
    h.render 'sales/new', sale:sale
  end

  def sales
    sales = familiar.done_sales.reverse
    h.content_tag :div, class:'sales' do
      h.render 'sales/sales', sales:sales if sales.present?
    end
  end

  def sales_count
    count = familiar.sales_count
    classes = ['sales_count']
    classes.push('low') if count < 10
    h.content_tag :div, class:classes do
      "Sales count: " +
      count.to_s 
    end
  end

  def skills
    h.content_tag :div, class:'skills' do
      "#{h.pl(:skill)}: #{familiar.skills.map{|e| h.link_to e.name,e, 'data-tip' => "#{e.description} #{e.modifier}*#{e.status}"}.join(', ').html_safe}".html_safe
    end
  end

  STATS = %w(maxhp maxatk maxdef maxwis maxagi)
  STATS.each do |stat|
    define_method(stat) do
      i = familiar.send(stat)
      h.content_tag :span, class:stat, 'data-tip' => "#{stat}: #{i}" do
        i.nil? ? "x" : i.to_s 
      end
    end
  end

  def stats
    h.content_tag :div, class:'stats' do
      "#{maxhp}/#{maxatk}/#{maxdef}/#{maxwis}/#{maxagi}".html_safe
    end
  end
end
