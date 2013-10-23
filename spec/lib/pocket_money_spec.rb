require 'spec_helper'
require 'active_support/core_ext/date/acts_like'
require 'rake'
require 'pocket_money'
Bernard::Application.load_tasks
describe PocketMoney do
  context "import data for a known database" do
    accounts               = Account.all
    transactions           = Transaction.all 
    categories             = Category.all
    payees                 = Payee.all
    departments            = Department.all
    splits                 = Split.all
    repeating_transactions = RepeatingTransaction.all

     #Table accounts 
    it "should have 3 accounts" do
      (accounts.count).should eq(3)
    end

    it "should have 3 knowed account" do
      (accounts.map(&:name).sort).should eq(["Cuenta Ahorro", "Efectivo", "Tarjeta"])
    end

    it "should have $1,650.00 current balance in 'cuenta ahorro'" do
      (accounts.find_by_name("Cuenta Ahorro").current_balance.to_f).should eq(950)
    end
    
    it "the second account should have a limit of $100" do
      (accounts[1].limit_amount.to_f).should eq(100)
    end

    it "all limit amount sum $600" do 
      (accounts.map(&:limit_amount).sum.to_f).should eq(600)
    end

    it "should have $740 current balance in 'efectivo'" do
      (accounts.find_by_name("Efectivo").current_balance.to_f).should eq(4740)
    end

    it "should have $350 current balance in 'tarjeta'" do
      (accounts.find_by_name("Tarjeta").current_balance.to_f).should eq(2050)
    end   

    #table transactions
    it "should have 37 transactions" do 
      (transactions.count).should eq(37)
    end

    it "the first transaction should have $1750 of amount" do
      (transactions.first.amount.to_f).should eq(1750)
    end

    it "should have transactions with transaction type" do
      types = transactions.map(&:pm_type)
      types.include?(nil).should eq(false)
      types.include?("").should 
    end

    it "should have transactions with valid account id" do
      transactions_account_id = transactions.map(&:account_id)
      ids_accounts = accounts.map(&:id)
      transactions_account_id.each do |account_id|
        (ids_accounts.include?(account_id)).should eq(true)
      end
    end

    it "should have transactions with amount" do
      amount_array = transactions.map(&:amount)
      amount_array.include?(nil).should eq(false)
      amount_array.include?("").should eq(false)
    end

    it "should have transactions with valid date" do
      dates = transactions.map(&:date)
      dates.each do |date|
        (date.acts_like?(:time)).should eq(true)
      end
    end
    
    it "first transaction should have category id 16" do
      transaction = transactions.first
      (transaction.category_id).should eq(16)
    end

    it "first transaction should have class personal" do
      transaction = transactions.first 
      (transaction.department_id).should eq(1)
    end

    #table split
    it "all aplits should have a transaction id" do
      all_splits = splits.map(&:transaction_id)
      all_splits.include?(nil).should eq(false)
      all_splits.include?("").should eq(false)
    end

    it "all splits should have a transaction with currency code" do
      currency_codes = splits.map(&:currency_code) 
      currency_codes.include?(nil).should eq(false)
      currency_codes.include?("").should eq(false)
    end

    it "the sum of the splits of a transactions should have same amount that transaction " do
      35.times do |count|
        transaction = transactions[count]
        splits = transaction.splits
        (splits.map(&:amount).sum.to_f).should eq(transaction.amount)
      end
    end
    
    it "first split should have a class id 1" do
      split = splits.first 
      (split.class_id).should eq(1)
    end

    it "amount of  transaction 2  should equal at transaction 37" do
      transaction_2  = transactions[1].amount.to_f
      transaction_37 = transactions[36].amount.to_f
      transaction_2.should eq(transaction_37)
    end

    it "amount of  transaction 4  should equal at transaction 36" do
      transaction_4  = transactions[3].amount.to_f
      transaction_36 = transactions[35].amount.to_f
      transaction_4.should eq(transaction_36)
    end

    #table department <--- class
    it "should have personal and negocios classes" do
      (departments.map(&:name)).should eq(["Personal", "Negocios"])
    end

    it "all class should have a uuid" do 
      departments = departments.map(&:uuid)
      departments.include?(nil).should eq(false)
      departments.include?("").should eq(false)
    end

    #table category
    it "should have 20 Categories" do
      (categories.count).should eq(20)
    end

    it "all categories should have a uuid" do 
      uuids = categories.map(&:uuid)
      uuids.include?(nil).should eq(false)
      uuids.include?("").should eq(false)
    end

    it "should include 'Salario' category" do
      names = categories.map(&:name)
      names.include?("Salario").should eq(true)
    end

    #table Payee 
    it "should have 9 payees" do
      (payees.count).should eq(9)
    end
    
    it "should include 'TangoSource' payee" do
      names = payees.map(&:name)
      names.include?("TangoSource").should eq(true)
    end

    it "Last payee should be 'Ahorro' " do
      (payees.last.name).should eq("Ahorro")
    end

    #table repeating_transactions
    it "should have 2 repeating transactions" do
      (repeating_transactions.count).should eq(2)
    end

    it "last repeating transaction should have a valid date" do
      transaction = repeating_transactions.last
      (transaction.end_date.acts_like?(:time)).should eq(true)
    end

    it "transaction 36 should have pm_type 5" do
      transaction = transactions[35]
      (transaction.pm_type).should eq(5)
    end

  end
end
