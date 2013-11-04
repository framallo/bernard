require 'spec_helper'

describe Account do
  let(:account) {Account.first}

  it "has a valid account" do
    account.should be_valid
  end

  #scopes
  it "should return 14 transaction for account id 1" do 
    (Account.find(1).active_transactions.count).should eq(14)
  end

  it "should return 9 transaction for account id 2" do 
    (Account.find(2).active_transactions.count).should eq(9)
  end

  it "should return 7 transaction for account id 3" do 
    (Account.find(3).active_transactions.count).should eq(7)
  end
end

