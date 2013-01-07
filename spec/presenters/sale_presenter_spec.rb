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
    before{ sale.should_receive(:regulated_value).and_return 40.00 }
    subject{ Capybara.string(presenter.value)}
    its(:text){ should eq '40.0' }
  end

  describe ".unit" do
    before{ sale.should_not_receive(:unit) }
    subject{ Capybara.string(presenter.unit)}
    its(:text){ should eq 'Mandrake' }
  end

  describe ".actions" do
    before{ controller.stub(:current_user){ nil }}
    let(:rendered){ Capybara.string(presenter.actions)}
    subject{ rendered }
    its(:text){ should eq 'Edit Delete' }

    context "edit link" do
      subject{ rendered.all('a')[0] }
      its(:text){ should eq 'Edit' } 
      specify{ subject[:href].should eq edit_sale_path(sale) }
    end

    context "delete link" do
      subject{ rendered.all('a')[1] }
      its(:text){ should eq 'Delete' } 
      specify{ subject[:href].should eq sale_path(sale) }
      specify{ subject['data-method'].should eq "delete" }
    end
  end
end
