require 'spec_helper'

describe FamiliarPresenter do
  let(:familiar){ Familiar.new }
  let(:presenter){ FamiliarPresenter.new(familiar,view) }

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
