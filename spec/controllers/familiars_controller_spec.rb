require 'spec_helper'

describe FamiliarsController do
  describe "#update" do
    let(:familiar){ create :familiar }

    context "stats" do
      before do
        Wiki.should_receive(:max_stats).and_return [12189, 13681, 11712, 14264, 11579]
        put :update, id:familiar.id, focus: :stats
      end

      describe "last familiar" do
        subject{ Familiar.last }
        its(:maxhp){ should be 12189 }
        its(:maxatk){ should be 13681 }
        its(:maxdef){ should be 11712 }
        its(:maxwis){ should be 14264 }
        its(:maxagi){ should be 11579 }
      end
    end

    context "skills" do
      before do
        Wiki.should_receive(:skill_infos).and_return [['Flash of Rage', 'Call down six random lightning bolts on foes.', 'Attack', 0.9, 'wis', '6 Foes']]
        put :update, id:familiar.id, focus: :skills
      end

      describe "last familiars-skill" do
        subject{ FamiliarsSkill.last }
        its(:familiar_id){ should be familiar.id }
        its(:skill_id){ should be Skill.last.id }
      end

      describe "last skill" do
        subject{ Skill.last }
        its(:name){ should eq 'Flash of Rage' }
        its(:description){ should eq 'Call down six random lightning bolts on foes.' }
        its(:kind){ should eq 'Attack' }
        its(:modifier){ should eq 0.9 }
        its(:status){ should eq 'wis' }
        its(:target){ should eq '6 Foes' }
      end
    end
  end

  describe "#create" do
    def send_post h={} 
      post :create, familiar:{name:h[:name]}
    end

    context "create" do
      before{ send_post name:'Odin'}

      describe Familiar do
        subject{ Familiar }
        its(:count){ should be 1 }
      end

      describe "created familiar" do
        subject{ Familiar.last }
        its(:name){ should eq 'Odin' }
      end

      describe "response" do
        subject{ response }
        it{ should redirect_to familiars_path }
      end

      describe "flash" do
        subject{ flash }
        its(:notice){ should eq 'Familiar created' }
      end
    end

    context "error" do
      before{ send_post }

      describe "response" do
        subject{ response }
        it{ should render_template :index }
      end
    end
  end
end
