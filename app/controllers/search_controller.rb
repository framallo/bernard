class SearchController < ApplicationController

  def index
    @transactions = Transaction.search params[:q]
  end

end
