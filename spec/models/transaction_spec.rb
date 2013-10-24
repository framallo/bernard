require 'spec_helper'

describe Transaction do

  let(:transactions) { Transaction.all }

  it { should belong_to(:account) }

  it { should have_many(:splits) }

  it "has a valid transaction" do
    (transactions.sample).should be_valid
  end
  
  #scopes
  it "should have 33 active transactions" do
    transactions.active.count.should eq(33)
  end

  it "should find a transaction given a payee name" do
    (transactions.search("TangoSource").count).should eq(2)
  end

  it "should return records with cleared value true " do
    (transactions.cleared.count).should eq(6)
  end

  it "should return records valid given two dates" do
    (transactions.interval("20131016", "20131021").count).should eq(32)
  end
  
  it "not should return records given two dates known" do
    (transactions.interval("19991016", "20021021").count).should eq(0)
  end
  
  it "should show the balance given a transaction" do
    transaction_balance = transactions.balance[36].balance
    (transaction_balance.to_f).should eq(1150)
  end

end
