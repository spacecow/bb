class FamiliarPresenter < BasePresenter
  presents :familiar

  def familiars(familiars)
    h.content_tag :table, class:'familiars' do
      h.render familiars
    end
  end

  def form
    h.render('familiars/form', familiar:familiar)
  end

  def median(tag) 
    h.content_tag tag, class:'median' do
      (tag == :div ? "Median: " : "") +
      familiar.median.to_s
    end
  end

  def name
    h.content_tag :td, class:'name' do
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
    h.content_tag :table, class:'sales' do
      h.render familiar.sales
    end
  end
end
