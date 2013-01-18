require 'spec_helper'

describe 'familiars/show' do
  let(:familiar){ stub_model Familiar }
  let(:sale){ stub_model(Sale).as_new_record }
  before do
    assign(:hash,{})
    assign(:interval_hash,{})
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
  it{ should have_selector 'div#total_mandrake_container' }
  it{ should_not have_selector 'div#per_day_mandrake_container' }
  it{ should have_selector 'div.sales' }
end
