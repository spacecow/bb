require 'spec_helper'

describe "sales/_sales" do
  let(:sales){ [stub_model(Sale)] }
  before do
    controller.stub(:current_user){ nil }
    render 'sales/sales', sales:sales
  end

  subject{ Capybara.string(rendered)}
  it{ should have_selector 'h2', text:'Sales' }
  it{ should have_selector 'table.sales' }
end
