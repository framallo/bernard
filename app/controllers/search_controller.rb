class SearchController < ApplicationController

  def index
    @transactions = Transaction.full.search params[:q].try(:strip)
  end

end
