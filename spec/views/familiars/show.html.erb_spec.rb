require 'spec_helper'

describe 'familiars/show' do
  let(:familiar){ stub_model Familiar }
  let(:sale){ stub_model(Sale).as_new_record }
  before do
    assign(:hash,{})
    assign(:familiar,familiar)
    assign(:sale,sale)
    familiar.should_receive(:name).and_return 'Odin'
    render
  end
  subject{ Capybara.string(rendered)}
  it{ should have_selector 'h1', text:'Odin' }
  it{ should have_selector 'div.image' }
  it{ should have_selector 'div.median' }
  it{ should have_selector 'div.sale.new' }
  it{ should have_selector 'div#container' }
  it{ should have_selector 'div.sales' }
end
