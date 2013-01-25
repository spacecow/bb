require 'spec_helper'

describe FamiliarsSkill do
  let(:familiar){ mock_model Familiar }
  let(:skill){ mock_model Skill }
  let(:fs){ stub_model FamiliarsSkill, familiar:familiar, skill:skill }

  describe ".max_damage" do
    subject{ fs.max_damage }
    before do
      familiar.should_receive(:max_stat).and_return 1000
      skill.should_receive(:target_no).and_return 3
      skill.should_receive(:status).and_return 'wis' 
      skill.should_receive(:modifier).and_return 1.5
    end
    it{ should eq 4500 } 
  end
end
