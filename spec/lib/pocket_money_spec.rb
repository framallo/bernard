require 'spec_helper'
require 'rake'
require 'pocket_money'
Bernard::Application.load_tasks
describe PocketMoney do
  context "import data for a database knowed" do

    before (:all) do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
      PocketMoney.import 
    end

    it "should have 3 accounts" do
      (Account.all.count).should eq(3)
    end
  end
end
