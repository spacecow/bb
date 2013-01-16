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

  describe ".note" do
    subject{Capybara.string presenter.note}

    context "without notes" do
      before{ skill.should_receive(:note).and_return nil }
      its(:text){ should be_blank } 
    end

    context "with notes" do
      before{ skill.should_receive(:note).and_return 'no additional data' }
      its(:text){ should eq 'Note: no additional data' } 
    end
  end
end
