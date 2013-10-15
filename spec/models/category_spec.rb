require 'spec_helper'

describe Category do
  let(:category) {create(:category)}

  it "has a valid category" do
    category.should be_valid
  end
end
