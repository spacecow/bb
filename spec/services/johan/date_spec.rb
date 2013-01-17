require 'spec_helper'

describe Johan::Date do
  describe ".intervall" do
    context "2 days between first and last" do
      arr = [Time.zone.parse('Thu, 10 Jan 2013 11:42:59 JST +09:00'), Time.zone.parse('Thu, 10 Jan 2013 11:43:39 JST +09:00'), Time.zone.parse('Thu, 12 Jan 2013 15:59:52 JST +09:00')]
      subject{ Johan::Date.interval arr }
      it{ should eq [Date.parse('Thu, 10 Jan 2013'), Date.parse('Fri, 11 Jan 2013'), Date.parse('Sat, 12 Jan 2013')] }
    end
  end
end
