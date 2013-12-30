class AccountsController < ApplicationController

  def index
    @accounts = Account.active
  end

  def show
    @account = Account.find(params[:id])
    @transactions = @account.active_transactions
  end
end
