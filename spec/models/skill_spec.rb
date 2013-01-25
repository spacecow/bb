require 'spec_helper'

describe Skill do
  let(:skill){ stub_model Skill }

  describe ".target_no" do
    context "specific number" do
      before{ skill.should_receive(:target).and_return '3 Foes' }
      subject{ skill.target_no }
      it{ should eq 3 } 
    end

    context "all" do
      before{ skill.should_receive(:target).and_return 'All Foes' }
      subject{ skill.target_no }
      it{ should eq 5 } 
    end
  end
end
