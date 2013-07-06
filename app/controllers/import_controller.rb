class ImportController < ApplicationController

  def index
    PocketMoney.import
  end

end
