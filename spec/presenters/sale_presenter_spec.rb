require 'spec_helper'

describe SalePresenter do
  let(:sale){ mock_model Sale }
  let(:presenter){ SalePresenter.new(sale,view) }

  describe "#sales" do
    context "without sales" do
      subject{ Capybara.string(presenter.sales([])) }
      its(:text){ should be_blank }
    end

    context "with sales" do
      before{ controller.stub(:current_user){ nil }}
      let(:sales){[stub_model(Sale)]} 
      subject{ Capybara.string(presenter.sales sales)}
      it{ should have_selector 'tr.sale', count:1}
    end
  end

  describe ".value" do
    before{ sale.should_receive(:value).and_return 40.00 }
    subject{ Capybara.string(presenter.value)}
    its(:text){ should eq '40.0' }
  end

  describe ".unit" do
    before{ sale.should_receive(:unit).and_return "Mandrake" }
    subject{ Capybara.string(presenter.unit)}
    its(:text){ should eq 'Mandrake' }
  end

  describe ".actions" do
    before{ controller.stub(:current_user){ nil }}
    let(:rendered){ Capybara.string(presenter.actions)}
    subject{ rendered }
    its(:text){ should eq 'Delete' }

    context "delete link" do
      subject{ rendered.find('a') }
      its(:text){ should eq 'Delete' } 
      specify{ subject[:href].should eq sale_path(sale) }
      specify{ subject['data-method'].should eq "delete" }
    end
  end
end
