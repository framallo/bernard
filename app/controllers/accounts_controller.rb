class AccountsController < ApplicationController

  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
    @transactions = @account.active_transactions
  end
end
