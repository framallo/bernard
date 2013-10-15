require 'spec_helper'

describe Transaction do
  let(:transaction) {create(:transaction)}

  it "has a valid transaction" do
    transaction.should be_valid
  end
end
