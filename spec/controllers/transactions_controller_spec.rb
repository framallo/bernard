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

  describe 'GET #edit' do
    it 'should render #edit view' do
      get :edit, id: transaction
      response.should render_template :edit
    end
    it 'should response with 200 http code' do
      get :edit, id: transaction
      response.should be_success
    end
  end
  #spec to post methods
  describe 'POST #create' do
    context "valid attributes" do
      it 'should create a new transaction' do
        expect{
          post :create, transaction: attributes_for(:transaction)
        }.to change(Transaction, :count).by(1)
      end
      it 'should redirect to #show view' do
        post :create, transaction: attributes_for(:transaction)
        response.should redirect_to Transaction.last
      end
    end
    context "invalid attributes" do
      it 'should not create a new transaction' do
        expect{
          post :create, transaction: attributes_for(:transaction, account_id: nil, amount: nil)
        }.to_not change(Transaction, :count)
      end
      it 'should render to #new view' do
        post :create, transaction: attributes_for(:transaction, account_id: nil, amount: nil)
        response.should render_template :new
      end

    end
  end

end
