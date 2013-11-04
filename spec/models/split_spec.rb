require 'spec_helper'

describe Split do
  let(:split) { Split.first }

  it "has a valid split" do
    split.should be_valid
  end
end

