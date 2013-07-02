class AccountsController < ApplicationController

  def index
    @accounts = Account.all
  end

  def show
    @account = Action.find(params[:id])
  end
end
