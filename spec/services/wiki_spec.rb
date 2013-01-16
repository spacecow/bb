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

  describe "skill_infos", wiki:true do
    describe "one skill" do
      subject{ Wiki.skill_infos('Odin') }
      it{ should eq [['Flash of Rage', 'Call down six random lightning bolts on foes.', '']] }
    end

    describe "infobox" do
      subject{ Wiki.skill_infos('Zeku') }
      it{ should eq [['Blitz Assault', 'Deal incredible damage to one foe, regardless of position.', '400% (ATK)']] }
    end

    describe "two skills" do
      subject{ Wiki.skill_infos('Galahad, Drake Knight') }
      it{ should eq [['Grace of Winds', 'Raise AGI of self and adjacent familiars.', 'The Grace of Winds ability is WIS based. Amount of AGI increase is equal to 50% of caster\'s WIS.'],['Whirlwind', 'Deal heavy AGI-based damage to three foes.', 'The Whirlwind ability is AGI based.']] }
    end
  end
end
