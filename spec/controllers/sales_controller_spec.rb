require 'spec_helper'

describe SalesController do
  describe "#delete" do
    let(:sale){ create :sale }
    before{ delete :destroy, id:sale.id }

    describe Sale do
      subject{ Sale }
      its(:count){ should eq 0 }
    end

    describe "response" do
      subject{ response }
      it{ should redirect_to familiar_path(sale.familiar)}
    end

    describe "flash" do
      subject{ flash }
      its(:notice){ should eq 'Sale deleted' }
    end
  end

  describe "#create" do
    def send_post h={}
      post :create, sale:{familiar_token:h[:familiar], value:40, unit:'Mandrake'}
    end

    context "create" do
      let(:odin){ create :familiar }
      before{ send_post familiar:odin.id}

      describe Sale do
        subject{ Sale }
        its(:count){ should be 1 }
      end

      describe "created sale" do
        subject{ Sale.last }
        its(:familiar_id){should be odin.id}
        its(:value){ should be_within(0.01).of(40.0) }
        its(:unit_mask){ should be 1 }
      end

      describe "response" do
        subject{ response }
        it{ should redirect_to familiar_path(odin) }
      end

      describe "flash" do
        subject{ flash }
        its(:notice){ should eq 'Sale created' }
      end

      describe "session, preferred_unit" do
        specify{ session[:preferred_unit].should eq 'Mandrake' }
      end
    end

    context "create with new familiar", focus:true do
      before{ send_post familiar:'<<<Odin>>>'}

      describe Sale do
        subject{ Sale }
        its(:count){ should be 1 }
      end

      describe "created familiar" do
        subject{ Familiar.last }
        it do p subject end
      end
    end

    context "error, no familiar given" do
      before{ send_post familiar:'' }

      describe "response" do
        subject{ response }
        it{ should render_template :index }
      end
    end
  end
end
