require 'assert'

class FamiliarPresenter < BasePresenter
  presents :familiar

  def actions
    h.content_tag :span, class:'actions' do
      h.link_to h.t(:update), h.familiar_path(familiar), method: :put
    end
  end

  def familiars(familiars)
    h.content_tag :ul, class:'familiars' do
      #h.render('familiars/header') +
      h.render(familiars) if familiars.present?
    end
  end

  def form
    h.render('familiars/form', familiar:familiar)
  end

  def image(tag,version=nil)
    h.content_tag tag, class:"image #{version}" do
      h.image_tag familiar.image_url(version)
    end
  end

  def median
    h.content_tag :div, class:'median' do
      "Median: " +
      familiar.median.to_s
    end
  end

  def name
    h.content_tag :div, class:'name' do
      familiar.name
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
    h.content_tag :div, class:'sales_count' do
      "Sales count: " +
      familiar.sales_count.to_s 
    end
  end
end
