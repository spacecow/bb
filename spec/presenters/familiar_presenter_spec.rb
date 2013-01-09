require 'spec_helper'

describe FamiliarPresenter do
  let(:familiar){ mock_model(Familiar).as_new_record }
  let(:presenter){ FamiliarPresenter.new(familiar,view) }

  describe ".actions" do
    let(:familiar){ mock_model(Familiar) }
    let(:rendered){ Capybara.string(presenter.actions)}
    subject{ rendered }
    its(:text){ should eq 'Update' }

    context "update link" do
      subject{ rendered.find('a') }
      its(:text){ should eq 'Update' } 
      specify{ subject[:href].should eq familiar_path(familiar) }
      specify{ subject['data-method'].should eq 'put'}
    end
    
  end

  describe ".sales" do
    context "without sales" do
      before{ familiar.should_receive(:done_sales).and_return [] }
      subject{ Capybara.string(presenter.sales) }
      its(:text){ should be_blank }
    end

    context "with sales" do
      let(:sales){ [stub_model(Sale)] }
      before do
        familiar.should_receive(:done_sales).and_return sales
        view.should_receive(:render).and_return nil
      end

      specify{ Capybara.string presenter.sales }  
    end
  end

  describe "#familiars" do
    context "without familiars" do
      let(:rendered){ Capybara.string(presenter.familiars([])) }
      subject{ rendered }
      its(:text){ should be_blank }
    end

    context "with familiars" do
      let(:familiars){ [stub_model(Familiar)] } 
      subject{ Capybara.string(presenter.familiars familiars)}
      it{ should_not have_selector 'tr th'}
      it{ should have_selector 'li.familiar.thumb', count:1}
    end
  end

  describe ".name" do
    before{ familiar.should_receive(:name).and_return 'odin' }
    let(:rendering){ Capybara.string(presenter.name)}
    subject{ rendering }
    its(:text){ should eq 'odin' }
  end

  describe ".median" do
    before{ familiar.should_receive(:median).and_return '40'}

    subject{ Capybara.string(presenter.median )}
    its(:text){ should eq 'Median: 40' }
  end

  describe ".sales_count" do
    context "without sales" do
      before{ familiar.should_receive(:sales_count).and_return 0 }
      subject{ Capybara.string(presenter.sales_count) }
      its(:text){ should eq "Sales count: 0" }
    end
  end
end
