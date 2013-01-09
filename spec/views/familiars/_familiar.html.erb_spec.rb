require 'spec_helper'

describe 'familiars/_familiar.html.erb' do
  let(:familiar){ stub_model Familiar }
  before do
    render familiar
  end

  subject{ rendered }
  it{ should have_selector 'div.image.thumb' }
  it{ should have_selector 'div.name' }
  it{ should have_selector 'div.median' }
  it{ should have_selector 'div.sales_count' }
  it{ should have_selector 'span.actions' }
end
