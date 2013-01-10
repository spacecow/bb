class SalePresenter < BasePresenter
  presents :sale

  def actions
    h.content_tag :td, class:'actions' do
      "#{edit_link} #{delete_link}".html_safe
    end
  end

  def form
    h.content_tag :div, class:'form' do
      h.render 'sales/form', sale:sale
    end
  end

  def sales(sales)
    h.content_tag :table, class:'sales' do
      h.render sales
    end
  end

  def unit
    h.content_tag :td, class:'unit' do
      "Mandrake"
    end
  end

  def value
    value = sale.regulated_value
    h.content_tag :td, class:'value' do
      ((value * 10).to_i/10.0).to_s unless value.nil?
    end
  end
end
