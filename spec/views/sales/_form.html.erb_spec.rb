require 'spec_helper'

describe 'sales/_form.html.erb' do
  let(:sale){ stub_model(Sale, created_at:Date.parse('2013-1-1')).as_new_record }
  let(:rendering){ Capybara.string(rendered)}
  subject{ rendering }
  before{ render 'sales/form', sale:sale }

  describe 'sold at' do
    subject{ rendering.find_field 'Sold at' }
    its(:value){ should eq '2013-01-01' }
  end

  describe 'default unit' do
    it{ should_not have_select 'Unit' }
    #it{ should have_select 'Unit', with_options:['Hearts Blood', 'Mandrake'], selected:'Mandrake' }
    it{ should have_field 'Note' }
  end

  describe 'preferred unit' do
    before{ session[:preferred_unit] = 'Hearts Blood' }
    it{ should_not have_select 'Unit' }
  end
end
