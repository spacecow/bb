require 'spec_helper'

describe 'sales/_new.html.erb' do
  let(:sale){ stub_model(Sale).as_new_record }
  before{ render 'sales/new', sale:sale }

  subject{ rendered }
  it{ should have_selector 'h2', text:'New Sale' }
  it{ should have_selector 'div.form' }
end
