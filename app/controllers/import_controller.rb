class ImportController < ApplicationController

  def index
    Thread.new do
      PocketMoney.import
    end
  end

end
