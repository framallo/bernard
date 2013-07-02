class AccountsController < ApplicationController

  # pm_types
  # 0 Withdrawal
  # 1 Deposit
  # 2 Transfer
  # 3 
  # 4
  # 5 Dunno
  #

  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
  end
end
