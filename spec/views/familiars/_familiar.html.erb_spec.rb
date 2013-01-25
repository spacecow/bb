require 'spec_helper'

describe 'familiars/_familiar.html.erb' do
  let(:familiar){ stub_model Familiar }
  subject{ rendered }

  context "basics" do
    before{ render familiar, len:20 }
    it{ should have_selector 'div.image.thumb' }
    it{ should have_selector 'div.name' }
    it{ should have_selector 'div.median' }
    it{ should have_selector 'div.stats' }
    it{ should have_selector 'div.max.damage' }
    it{ should have_selector 'div.skills' }
    it{ should have_selector 'span.actions' }
  end

  context "low sales" do
    before do
      familiar.should_receive(:sales_count).and_return 10
      render familiar, len:20
    end
    it{ should have_selector 'div.sales_count' }
    it{ should_not have_selector 'div.sales_count.low' }
  end

  context "high sales" do
    before do
      familiar.should_receive(:sales_count).and_return 9 
      render familiar, len:20
    end
    it{ should have_selector 'div.sales_count.low' }
  end
end
