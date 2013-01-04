require 'spec_helper'

describe 'sales/_sale.html.erb' do
  let(:sale){ stub_model Sale }
  before do
    controller.stub(:current_user){ nil }
    render sale
  end

  subject{ rendered }
  it{ should have_selector 'td.value' }
  it{ should have_selector 'td.unit' }
  it{ should have_selector 'td.actions' }
end
