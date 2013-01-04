class SalePresenter < BasePresenter
  presents :sale

  def sales(sales)
    h.content_tag :table, class:'sales' do
      h.render sales
    end
  end

  def actions
    h.content_tag :td, class:'actions' do
      delete_link
    end
  end

  def form
    h.render 'sales/form', sale:sale
  end

  def value
    value = sale.value
    h.content_tag :td, class:'value' do
      ((value * 10).to_i/10.0).to_s unless value.nil?
    end
  end

  def unit
    h.content_tag :td, class:'unit' do
      sale.unit
    end
  end
end
