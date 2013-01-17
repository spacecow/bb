require 'spec_helper'

describe Johan::Time do
  describe ".seconds" do
    context '15:16' do
      let(:time){Time.zone.parse('2013-01-17 15:16')}
      subject{ Johan::Time.seconds(time) }
      it{ should be 54960 }
    end
  end
end
