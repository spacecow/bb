require 'spec_helper'

describe Johan::DateTime do
  describe ".new" do
    context '' do
      let(:now){ Time.zone.now }
      subject{ Johan::DateTime.new(Date.parse '2013-01-16')}
      it{ should eq Time.zone.parse "2013-01-16 #{now.hour}:#{now.min}:#{now.sec}" }
    end
  end
end
