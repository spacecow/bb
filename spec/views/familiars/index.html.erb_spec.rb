require 'spec_helper'

describe 'familiars/index.html.erb' do
  let(:familiar){ mock_model(Familiar).as_new_record }
  let(:sale){ stub_model(Sale).as_new_record }
  before do
    assign(:familiars,[])
    assign(:familiar,familiar)
    assign(:sale,sale)
    render
  end
  let(:rendering){ Capybara.string(rendered)}

  subject{ rendering }
  it{ should_not have_selector 'h1', text:'Familiars' }
  it{ should have_selector 'div.familiars' }
  it{ should have_selector 'div.sale.new' }
  it{ should_not have_selector 'div.familiar.new' }
end
