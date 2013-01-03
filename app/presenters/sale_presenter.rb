class SalePresenter < BasePresenter
  presents :sale

  def form
    h.render 'sales/form', sale:sale
  end
end
