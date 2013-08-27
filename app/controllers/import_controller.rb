class ImportController < ApplicationController

  def index
    Thread.new do
      PocketMoney.import
    end
    redirect_to :back
  end

end
