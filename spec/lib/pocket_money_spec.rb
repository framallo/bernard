require 'spec_helper'
require 'rake'
require 'pocket_money'
Bernard::Application.load_tasks
describe PocketMoney do
  context "import data for a known database" do

    before (:all) do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
      PocketMoney.import 
    end
    #Table accounts 
    it "should have 3 accounts" do
      (Account.all.count).should eq(3)
    end

    it "should have 3 knowed account" do
      (Account.all.map(&:name).sort).should eq(["Cuenta Ahorro", "Efectivo", "Tarjeta"])
    end

    it "should have $1,650.00 current balance in 'cuenta ahorro'" do
      (Account.find_by_name("Cuenta Ahorro").current_balance.to_f).should eq(1650)
    end
    
    it "the second account should have a limit of $100" do
      (Account.find(2).limit_amount.to_f).should eq(100)
    end

    it "all limit amount sum $600" do 
      (Account.all.map(&:limit_amount).sum.to_f).should eq(600)
    end

    it "should have $740 current balance in 'efectivo'" do
      (Account.find_by_name("Efectivo").current_balance.to_f).should eq(740)
    end

    it "should have $740 current balance in 'tarjeta'" do
      (Account.find_by_name("Tarjeta").current_balance.to_f).should eq(350)
    end   

    #table transactions
    it "should have 35 transactions" do 
      (Transaction.all.count).should eq(35)
    end

    it "should have transactions with account id" do
      ids_array = Transaction.all.map(&:account_id)
      ids_array.include?(nil).should eq(false)
      ids_array.include?("").should eq(false)
    end

    it "should have transactions with amount" do
      amount_array = Transaction.all.map(&:amount)
      amount_array.include?(nil).should eq(false)
      amount_array.include?("").should eq(false)
    end
    
    it "first transaction should have category id 16" do
      transaction = Transaction.first
      (transaction.category_id).should eq(16)
    end

    it "first transaction should have class personal" do
      transaction = Transaction.first 
      (transaction.department_id).should eq(1)
    end
    #table split
    it "all aplits should have a transaction id" do
      all_splits = Split.all.map(&:transaction_id)
      all_splits.include?(nil).should eq(false)
      all_splits.include?("").should eq(false)
    end

    it "the sum of the splits of a transactions should have same amount that transaction " do
      35.times do |count|
        transaction = Transaction.find(count+1)
        splits = transaction.splits
        (splits.map(&:amount).sum.to_f).should eq(transaction.amount)
      end
    end
    
    it "first split should have a class id 1" do
      split = Split.first 
      (split.class_id).should eq(1)
    end

    #table department <--- class
    it "should have personal and negocios classes" do
      (Department.all.map(&:name)).should eq(["Personal", "Negocios"])
    end

    it "all class should have a uuid" do 
      departments = Department.all.map(&:uuid)
      (departments.include?(nil)).should eq(false)
      (departments.include?("")).should eq(false)
    end

  end
end
