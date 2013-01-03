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

  describe ".median" do
    let(:familiar){ stub_model Familiar }

    context "even" do
      before{ familiar.should_receive(:regulated_sale_values).and_return [10,30,10,20]}
      specify{ familiar.median.should eq 20 }
    end

    context "odd" do
      before{ familiar.should_receive(:regulated_sale_values).and_return [10,30,20]}
      specify{ familiar.median.should eq 20 }
    end
  end 
end
