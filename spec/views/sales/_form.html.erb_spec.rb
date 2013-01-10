require 'spec_helper'

describe 'sales/_form.html.erb' do
  let(:sale){ stub_model(Sale).as_new_record }
  let(:rendering){ Capybara.string(rendered)}
  subject{ rendering }

  describe 'default unit' do
    before{ render 'sales/form', sale:sale }
    it{ should_not have_select 'Unit' }
    #it{ should have_select 'Unit', with_options:['Hearts Blood', 'Mandrake'], selected:'Mandrake' }
    it{ should have_field 'Note' }
  end

  describe 'preferred unit' do
    before do
      session[:preferred_unit] = 'Hearts Blood'
      render 'sales/form', sale:sale
    end
    it{ should_not have_select 'Unit' }
    #it{ should have_select 'Unit', with_options:['Hearts Blood', 'Mandrake'], selected:'Hearts Blood' }
  end
end
