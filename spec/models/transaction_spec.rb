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

  it "should find a transaction given a payee name" do
    (transactions.search("TangoSource").count).should eq(2)
  end

  it "should find a transaction given a uuid" do
    (transactions.uuid("d75b07fb-702d-4fe5-a89f-69b3db98cb1f").payee_name).should eq("Coopel")
  end

  it "when is passed a invalid uuid should return all records" do
    (transactions.uuid("####-####-##-01").count).should eq(37)
  end

  it "should return records with cleared value true " do
    (transactions.cleared.count).should eq(6)
  end
end
