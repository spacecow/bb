require 'spec_helper'

describe 'familiars/_familiar.html.erb' do
  let(:familiar){ stub_model Familiar }
  before do
    render familiar
  end

  subject{ rendered }
  it{ should have_selector 'td.image.thumb' }
  it{ should have_selector 'td.name' }
  it{ should have_selector 'td.median' }
  it{ should have_selector 'td.sales_count' }
  it{ should have_selector 'td.actions' }
end
