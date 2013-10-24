require 'spec_helper'

describe Account do
  let(:account) {Account.first}

  it "has a valid account" do
    account.should be_valid
  end
end

