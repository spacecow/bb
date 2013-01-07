require 'spec_helper'

describe "layouts/_site_nav.html.erb" do
  before do
    render
  end

  context "Familiars" do
    subject{ Capybara.string(rendered).find('a') }
    its(:text){ should eq 'Familiars' }
    specify{ subject[:href].should eq familiars_path }
  end
end
