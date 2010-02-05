require File.dirname(__FILE__) + '/../spec_helper'

describe Region do
  it "should be valid" do
    Region.new.should be_valid
  end
end
