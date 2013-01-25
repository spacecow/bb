require 'spec_helper'

describe "skills/show" do
  let(:skill){ stub_model Skill }
  before do
    skill.should_receive(:name).and_return 'Flash of Rage'
    assign(:skill,skill)
    render
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'h1', text:'Flash of Rage' }
  it{ should have_selector 'div.description' }
  it{ should_not have_selector 'div.note' }
  it{ should have_selector 'div.familiars' }
end
