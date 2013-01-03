require 'spec_helper'

describe Sale do
  context "validation error" do
    it "value zero" do
      lambda{ create :sale, value:'yeah' }.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Value cannot be zero')
    end 
  end

  describe '.regulated_value' do
    context 'in Hearts Blood' do
      let(:sale){ stub_model Sale, unit_mask:0, value:20 }
      subject{ sale.regulated_value }
      it{ should eq 40 }
    end

    context 'in Mandrake' do
      let(:sale){ stub_model Sale, unit_mask:1, value:40 }
      subject{ sale.regulated_value }
      it{ should eq 40 }
    end
  end
end
