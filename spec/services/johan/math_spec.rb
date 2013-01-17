require 'spec_helper'

describe Johan::Date do
  describe "#median" do
    context "unordered list" do
      subject{ Johan::Math.median [38.0, 41.0, 55.0, 38.0, 39.0, 45.0, 52.0, 39.0, 40.0] }
      it{ should be_within(0.01).of(40.0) }
    end
  end
end
