require 'spec_helper'

describe FamiliarPresenter do
  let(:familiar){ mock_model(Familiar).as_new_record }
  let(:presenter){ FamiliarPresenter.new(familiar,view) }

  describe ".sales" do
    context "without sales" do
      before{ familiar.should_receive(:sales).and_return [] }
      let(:rendered){ Capybara.string(presenter.sales) }
      subject{ rendered }
      its(:text){ should be_blank }
    end

    context "with sales" do
      let(:sales){ [stub_model(Sale)] }
      before do
        familiar.should_receive(:sales).and_return sales
        controller.stub(:current_user){ nil }
      end
      let(:rendered){ Capybara.string(presenter.sales)}  
      subject{ rendered }
      it{ should have_selector 'tr.sale', count:1}
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
      let(:rendered){ Capybara.string(presenter.familiars familiars)}
      subject{ rendered }
      it{ should have_selector 'tr.familiar', count:1}
    end
  end

  describe ".name" do
    before{ familiar.should_receive(:name).and_return 'odin' }
    subject{ Capybara.string(presenter.name)}
    its(:text){ should eq 'odin' }
  end

  describe ".median" do
    before{ familiar.should_receive(:median).and_return '40'}

    context "table" do
      subject{ Capybara.string(presenter.median(:td))}
      its(:text){ should eq '40' }
    end

    context "section" do
      subject{ Capybara.string(presenter.median(:div))}
      its(:text){ should eq 'Median: 40' }
    end
  end
end
