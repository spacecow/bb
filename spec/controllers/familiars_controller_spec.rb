require 'spec_helper'

describe FamiliarsController do
  describe "#update" do
    let(:familiar){ create :familiar }
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
