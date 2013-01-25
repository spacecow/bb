require 'spec_helper'

describe Familiar do
  context "create" do
    context "validation error" do
      it "name blank" do
        lambda{ create :familiar, name:'' }.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Name can\'t be blank')
      end

      it "name duplicated" do
        create :familiar, name:'odin'
        lambda{ create :familiar, name:'odin' }.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Name has already been taken')
      end

    end
  end 

  context "delete" do
    context "associated sales" do
      let(:sale){ create :sale }
      before{ sale.familiar.destroy }

      describe Familiar do
        subject{ Familiar }
        its(:count){ should be 0 }
      end

      describe Sale do
        subject{ Sale }
        its(:count){ should be 0 }
      end
    end
  end

  # ------------------ METHODS ----------------

  describe ".regulated_sale_values" do
    let(:fam){ create :familiar }
    before do
      create :sale, familiar_id:fam.id, value:11, created_at:Date.today
      create :sale, familiar_id:fam.id, value:10, created_at:Date.yesterday
    end

    context "all values" do
      subject{ fam.regulated_sale_values }
      it{ should eq [10,11] }
    end

    context "only the last" do
      subject{ fam.regulated_sale_values(1) }
      it{ should eq [11] }
    end
  end

  describe ".last_sale_created_at" do
    let(:familiar){ stub_model Familiar }
  
    context "without sales" do
      before{ familiar.should_receive(:sales).and_return [] }
      specify{ familiar.last_sale_created_at.should be_nil }
    end     

    context "with sales" do
      let(:sale){ mock_model Sale, created_at:1.hour.ago }
      before{ familiar.should_receive(:sales).and_return [sale] }
      specify{ familiar.last_sale_created_at.should be_within(1.second).of(1.hour.ago) }
    end
  end

  describe ".max_damage" do
    let(:familiar){ stub_model Familiar }
    subject{ familiar.max_damage }

    context "without skills" do
      before{ familiar.should_receive(:familiars_skills).and_return [] }
      it{ should eq 0 }
    end

    context "with skill" do
      let(:fs){ mock_model FamiliarsSkill }
      before do
        fs.should_receive(:max_damage).and_return 3000
        familiar.should_receive(:familiars_skills).and_return [fs]
      end
      it{ should eq 3000 }
    end
  end

  describe ".max_stat" do
    context 'nil' do
      let(:familiar){ stub_model Familiar }
      subject{ familiar.max_stat nil }
      it{ should eq 0 } 
    end

    context 'atk' do
      let(:familiar){ stub_model Familiar, maxatk:3000 }
      subject{ familiar.max_stat 'atk' }
      it{ should eq 3000 } 
    end
  end

  describe ".median" do
    let(:familiar){ stub_model Familiar }

    context "zero" do
      before{ familiar.should_receive(:regulated_sale_values).and_return []}
      specify{ familiar.median.should eq 0 }
    end

    context "even number of sales" do
      before do
        familiar.should_receive(:regulated_sale_values).and_return [10,30,10,20]
      end
      specify{ familiar.median.should eq 20.0 }
    end

    context "odd" do
      before do
        familiar.should_receive(:regulated_sale_values).and_return [20,10,30]
        familiar.should_receive(:sales).and_return [20,10,30]
      end
      specify{ familiar.median.should eq 20 }
    end
  end 

  describe "static_image_url", wiki:true do
    context "Odin, src" do
      let(:familiar){ stub_model Familiar }
      before{ familiar.should_receive(:name).and_return 'Odin' }
      subject{ familiar.static_image_url }
      it{ should eq "http://images4.wikia.nocookie.net/__cb20130106211342/bloodbrothersgame/images/thumb/c/ca/Odin_Figure.png/250px-Odin_Figure.png" } 
    end

    context "Ghislandi, data-src" do
      let(:familiar){ stub_model Familiar }
      before{ familiar.should_receive(:name).and_return 'Ghislandi, The Iron Wall' }
      subject{ familiar.static_image_url }
      it{ should eq "http://images2.wikia.nocookie.net/__cb20130106212157/bloodbrothersgame/images/thumb/2/21/Ghislandi%2C_The_Iron_Wall_Figure.png/250px-Ghislandi%2C_The_Iron_Wall_Figure.png" }
    end

    context "Freila, wrong name" do
      let(:familiar){ stub_model Familiar }
      before{ familiar.should_receive(:name).and_return 'Freila' }
      it{ lambda{ familiar.static_image_url }.should raise_error OpenURI::HTTPError }
    end
  end
end
