require 'spec_helper'

describe SkillPresenter do
  let(:skill){ mock_model Skill }
  let(:presenter){ SkillPresenter.new(skill,view) }

  describe ".description" do
    subject{Capybara.string presenter.description}

    context "without description" do
      before{ skill.should_receive(:description).and_return nil }
      its(:text){ should be_blank } 
    end

    context "with description" do
      before{ skill.should_receive(:description).and_return 'many flashes' }
      its(:text){ should eq 'Description: many flashes' } 
    end
  end
end
