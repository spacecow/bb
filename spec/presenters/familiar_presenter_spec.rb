require 'spec_helper'

describe FamiliarPresenter do
  let(:familiar){ mock_model(Familiar) }
  let(:presenter){ FamiliarPresenter.new(familiar,view) }

  describe ".actions" do
    let(:rendered){ Capybara.string(presenter.actions)}
    subject{ rendered }
    its(:text){ should eq 'Edit Update(Image Stats Skills)' }

    context "edit link" do
      subject{ rendered.all('a')[0] }
      its(:text){ should eq 'Edit' } 
      specify{ subject[:href].should eq edit_familiar_path(familiar) }
      specify{ subject['data-method'].should be_nil}
    end

    context "update image link" do
      subject{ rendered.all('a')[1] }
      its(:text){ should eq 'Image' } 
      specify{ subject[:href].should eq familiar_path(familiar, focus: :image) }
      specify{ subject['data-method'].should eq 'put'}
    end
    
    context "update stats link" do
      subject{ rendered.all('a')[2] }
      its(:text){ should eq 'Stats' } 
      specify{ subject[:href].should eq familiar_path(familiar, focus: :stats) }
      specify{ subject['data-method'].should eq 'put'}
    end

    context "update skills link" do
      subject{ rendered.all('a')[3] }
      its(:text){ should eq 'Skills' } 
      specify{ subject[:href].should eq familiar_path(familiar, focus: :skills) }
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

  describe ".skill" do
    let(:skill){ mock_model(Skill, name:'Slashing Blade') }
    before{ familiar.should_receive(:skills).and_return [skill] }
    let(:rendering){ Capybara.string presenter.skills }
    subject{ rendering }
    its(:text){ should eq 'Skills: Slashing Blade' }

    context "link" do
      subject{ rendering.find 'a' }
      its(:text){ should eq 'Slashing Blade' }
      specify{ subject[:href].should eq skill_path(skill) }
    end
  end

  describe "#familiars" do
    context "without familiars" do
      context "section" do
        subject{ Capybara.string(presenter.familiars([],:div,'max_damage',20)) }
        its(:text){ should be_blank }
      end
      context "list" do
        subject{ Capybara.string(presenter.familiars({},:ul,'max_damage',20)) }
        its(:text){ should be_blank }
      end
    end

    context "with familiars" do
      let(:familiars){[stub_model(Familiar)]} 

      context "section" do
        subject{ Capybara.string(presenter.familiars familiars,:div,'max_damage',20)}
        it{ should_not have_selector 'tr th'}
        it{ should have_selector 'h2' }
        it{ should have_selector 'ul.familiars' } 
      end

      context "list" do
        context "sorted on median" do
          subject{ Capybara.string(presenter.familiars familiars,:ul,'median',20)}
          it{ should_not have_selector 'tr th'}
          it{ should_not have_selector 'h2' }
          it{ should have_selector 'li.familiar.thumb', count:1 } 
          it{ should have_selector 'li', count:2 } 
        end

        context "sorted on maxagi" do
          let(:familiars){[stub_model(Familiar)]} 
          subject{ Capybara.string(presenter.familiars familiars,:ul,:maxagi,20)}
          it{ should_not have_selector 'tr th'}
          it{ should_not have_selector 'h2' }
          it{ should have_selector 'li.familiar.thumb', count:1 } 
          it{ should have_selector 'li', count:1 } 
        end
      end
    end
  end

  describe ".name" do
    before do
      familiar.should_receive(:name).and_return 'Odin'
      familiar.should_not_receive(:last_sale_created_at)
    end
    let(:rendering){ Capybara.string(presenter.name)}
    subject{ rendering }
    its(:text){ should eq 'Odin' }

    context "link" do
      subject{ rendering.find('a') }
      its(:text){ should eq 'Odin' }
      specify{ subject[:href].should eq familiar_path(familiar)}
    end
  end

  describe ".max_damage" do
    subject{ Capybara.string(presenter.max_damage)}

    context "without skill" do
      before{ familiar.should_receive(:familiars_skills).and_return [] }
      its(:text){ should be_blank }
    end

    context "with boost skill" do
      let(:fs){ mock_model FamiliarsSkill }
      before do
        fs.should_receive(:kind).and_return 'Opening'
        familiar.should_receive(:familiars_skills).and_return [fs]
      end
      its(:text){ should be_blank }
    end

    context "with attack skill" do
      let(:fs){ mock_model FamiliarsSkill}
      before do
        fs.should_receive(:kind).and_return 'Attack'
        fs.should_receive(:max_damage).and_return '4500'
        familiar.should_receive(:familiars_skills).and_return [fs]
      end
      its(:text){ should eq "Max damage: 4500" }
    end
  end

  describe ".median" do
    before do
      familiar.should_receive(:median).and_return '40'
      familiar.should_receive(:last_sale_created_at).and_return 1.hour.ago
    end
    subject{ Capybara.string(presenter.median(1) )}
    its(:text){ should eq 'Median: 40 (about 1 hour ago)' }
  end

  describe ".sales_count" do
    context "without sales" do
      before{ familiar.should_receive(:sales_count).and_return 0 }
      subject{ Capybara.string(presenter.sales_count) }
      its(:text){ should eq "Sales count: 0" }
    end
  end

  describe ".stats" do
    context "no stats" do
      subject{ Capybara.string(presenter.stats) }
      its(:text){ should eq "x/x/x/x/x" }
      it{ should have_selector 'span.maxhp' }
      it{ should have_selector 'span.maxatk' }
      it{ should have_selector 'span.maxdef' }
      it{ should have_selector 'span.maxwis' }
      it{ should have_selector 'span.maxagi' }
    end
  end
end
