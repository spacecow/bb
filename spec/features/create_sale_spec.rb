require 'spec_helper'

describe 'Familiar index' do
  context "sale" do
    before do
      visit familiars_path
      fill_in 'Familiar', with:'<<<Odin>>>'
      select 'Hearts Blood', from:'Unit'
      fill_in 'Value', with:20
    end

    context "create" do
      before{ click_button 'Create Sale' }

      describe "created sale" do
        subject{ Sale.last }
        its(:unit_mask){ should eq 0 }
      end
    end

    context "error, value wrong" do
      before do
        fill_in 'Value', with:'letters'
        click_button 'Create Sale'
      end

      it do end
    end
  end
end
