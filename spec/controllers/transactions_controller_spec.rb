require 'spec_helper'
describe TransactionsController  do 
  describe "Get index" do
    it "render the index templates" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
