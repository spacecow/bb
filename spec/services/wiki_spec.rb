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
end
