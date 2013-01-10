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

  describe ".median" do
    let(:familiar){ stub_model Familiar }

    context "zero" do
      before{ familiar.should_receive(:regulated_sale_values).and_return []}
      specify{ familiar.median.should eq 0 }
    end

    context "even" do
      before{ familiar.should_receive(:regulated_sale_values).and_return [10,30,10,20]}
      specify{ familiar.median.should eq 20 }
    end

    context "odd" do
      before{ familiar.should_receive(:regulated_sale_values).and_return [10,30,20]}
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
