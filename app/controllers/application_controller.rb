class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :menu_accounts

  def menu_accounts
    @menu_accounts ||= Account.all
  end

end
