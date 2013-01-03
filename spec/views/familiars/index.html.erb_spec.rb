require 'spec_helper'

describe 'familiars/index.html.erb' do
  let(:familiar){ mock_model(Familiar).as_new_record }
  let(:sale){ stub_model(Sale).as_new_record }
  before do
    assign(:familiar,familiar)
    assign(:sale,sale)
    render
  end
  let(:rendering){ Capybara.string(rendered)}

  subject{ rendering }
  it{ should have_selector 'h1', text:'Familiars' }
  it{ should have_selector 'table.familiars' }
  it{ should have_selector 'div.sale.new' }
  it{ should have_selector 'div.familiar.new' }
end
