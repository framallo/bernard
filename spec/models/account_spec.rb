require 'spec_helper'

describe Account do
  let(:account)         { create(:account) }
  let(:deleted_account) { create(:deleted_account) }

  context 'Relations' do
    it { is_expected.to have_many :transactions }
    it { is_expected.to have_many :splits }
  end

  #it "has a valid account" do
    #expect(account).to be_valid
  #end

  describe "active scope" do
    it "has valid accounts" do
      expect(Account.active).to contain_exactly(account)
    end
    it "hides deleted accounts" do
      expect(Account.active).not_to include(deleted_account)
    end
  end
  describe "#active_transactions"
  describe "#basic_balance"
  describe "#cleared_balance"
  describe "#current_balance"
  describe "#future_balance"
  describe "#available_funds"

end

