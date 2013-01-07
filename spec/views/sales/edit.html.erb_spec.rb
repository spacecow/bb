require 'spec_helper'

describe "sales/edit.html.erb" do
  let(:sale){ stub_model Sale }
  before do
    assign(:sale,sale)
    render
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'h1' }
  it{ should have_selector 'form.edit_sale' }
end
