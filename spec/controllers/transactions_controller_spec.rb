require 'spec_helper'
describe TransactionsController  do 
  let(:transaction) { create(:transaction) }
  #spec to GET methods
  describe "Get index" do
    it "should render the index templates" do
      get :index
      expect(response).to render_template("index")
    end
    it "should response with 200 http code" do
      get :index 
      response.should be_succes
    end
  end

  describe 'GET #new' do
    it 'should render new template' do
      get :new
      response.should render_template :new
    end
    it 'should response with 200 code' do
      get :new
      response.should be_success
    end
  end

  describe 'GET #show' do
    it 'should redirect to #show view' do
      get :show, id: transaction
      response.should render_template :show
    end
    it 'should response with 200 http code' do
      get :show, id: transaction
      response.should be_success
    end
  end
end
