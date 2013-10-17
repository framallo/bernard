class AccountsController < ApplicationController

  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
    @filter = @account.transactions.filter(params)
  end
end
