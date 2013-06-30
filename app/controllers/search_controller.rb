class SearchController < ApplicationController

  def index
    @transactions = Transaction.search params[:q].try(:strip)
  end

end
