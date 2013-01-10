require 'spec_helper'

describe "familiars/edit" do
  let(:familiar){ mock_model Familiar }
  before do
    assign(:familiar, familiar)
    render
  end
  subject{ Capybara.string(rendered)}
  it{ should have_selector 'h1', text:'Edit Familiar' }
  it{ should have_selector 'div.form' }
end
