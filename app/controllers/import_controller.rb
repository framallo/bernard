class ImportController < ApplicationController

  def index
    PocketMoney.import
    redirect_to :back
  end

end
