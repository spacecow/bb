require 'spec_helper'

describe FamiliarsController do
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
