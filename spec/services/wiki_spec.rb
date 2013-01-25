require 'spec_helper'

describe Wiki do
  describe "wiki_url", nowiki:true do
    describe "familiar name" do
      subject{ Wiki.url('Griffin II') }
      it{ should eq 'http://bloodbrothersgame.wikia.com/wiki/Griffin_II' }
    end 

    describe "wiki & familiar name" do
      subject{ Wiki.url('/wiki/Odin_Stormgod_II') }
      it{ should eq 'http://bloodbrothersgame.wikia.com/wiki/Odin_Stormgod_II' }
    end 
  end

  describe "max_evolved_url", wiki:true do
    describe "four step familiar", wiki:true do
      subject{ Wiki.max_evolved_url('Odin') }
      it{ should eq 'http://bloodbrothersgame.wikia.com/wiki/Odin_Stormgod_II' }
    end

    describe "two step familiar" do
      subject{ Wiki.max_evolved_url('Galahad, Drake Knight') }
      it{ should eq 'http://bloodbrothersgame.wikia.com/wiki/Galahad,_Drake_Knight_II' }
    end

    describe "one step familiar" do
      subject{ Wiki.max_evolved_url('Soulflayer') }
      it{ should eq 'http://bloodbrothersgame.wikia.com/wiki/Soulflayer' }
    end
  end

  describe "max_stats", wiki:true do
    describe "Odin" do
      subject{ Wiki.max_stats('Odin') }
      it{ should eq [12189, 13681, 11712, 14264, 11579] }
    end
  end

  describe "skill_paths", wiki:true do
    describe "one skill" do
      subject{ Wiki.skill_paths('Odin') }
      it{ should eq ['/wiki/Category:Flash_of_Rage'] }
    end

    describe "two skills" do
      subject{ Wiki.skill_paths('Galahad, Drake Knight') }
      it{ should eq ['/wiki/Category:Grace_of_Winds', '/wiki/Category:Whirlwind'] }
    end
  end

  describe "odin skill attributes" do
    let(:doc){ Nokogiri::HTML(open 'spec/data/Category:Flash_of_Rage.html') }

    describe "skill_kind" do
      subject{ Wiki.skill_kind(doc) }
      it{ should eq 'Attack' }
    end

    describe "skill_modifier" do
      subject{ Wiki.skill_modifier(doc) }
      it{ should eq 0.9 }
    end

    describe "skill_status" do
      subject{ Wiki.skill_status(doc) }
      it{ should eq 'wis' }
    end

    describe "skill_target" do
      subject{ Wiki.skill_target(doc) }
      it{ should eq '6 Foes' }
    end

    describe "skill_infos" do
      describe "one skill" do
        subject{ Wiki.skill_info(doc) }
        it{ should eq ['Flash of Rage', 'Call down six random lightning bolts on foes.', 'Attack', 0.9, 'wis', '6 Foes'] }
      end
    end
  end

  describe "zeku skill attributes" do
    let(:doc){ Nokogiri::HTML(open 'spec/data/Category:Blitz_Assault.html') }
    describe "skill_infos" do
      describe "one skill" do
        subject{ Wiki.skill_info(doc) }
        it{ should eq ['Blitz Assault', 'Deal incredible damage to one foe, regardless of position.', 'Attack', 4.0, 'atk', '1 Foe'] }
      end
    end
  end

  describe "skill_infos", wiki:true do
    describe "two skills" do
      subject{ Wiki.skill_infos('Galahad, Drake Knight') }
      it{ should eq [['Grace of Winds', 'Raise AGI of self and adjacent familiars', 'Opening', 0.5, 'wis', '3 Allies Self & Adjacent'],['Whirlwind', 'Deal heavy AGI-based damage to three foes.', 'Attack', 2.5, 'agi', '3 Foes']] }
    end
  end
end
