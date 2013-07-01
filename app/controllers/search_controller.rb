class SearchController < ApplicationController

  def index
    @transactions = Transaction.active.search params[:q].try(:strip)
  end

end
