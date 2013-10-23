require 'spec_helper'

describe Transaction do
  transactions = Transaction.all

  it { should belong_to(:account) }

  it { should have_many(:splits) }

  it "has a valid transaction" do
    (transactions.sample).should be_valid
  end
  
  #scopes
  it "should have 33 active transactions" do
    transactions.active.count.should eq(33)
  end

  it "should find a transaction given a uuid" do
    (transactions.search("TangoSource").count).should eq(2)
  end

  it "" do
  end
end
