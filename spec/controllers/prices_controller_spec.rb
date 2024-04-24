# spec/controllers/prices_controller_spec.rb
require 'rails_helper'

RSpec.describe PricesController, type: :controller do
  before do
    @price = Price.create!(ask: 106700.00000000,
                          bid: 107800.00000000,
                          last: 104000.00000000)
    
  end
  describe "GET #index" do
    it "should get :index" do
      get :index
      expect(response).to be_successful
    end
  end
  
  describe "GET #new" do
    it "should get :new" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit/:id" do
    it "should get :edit/:id" do
      get :edit, params: { id: @price.id }
      expect(response).to be_successful
    end
  end

  describe "#update" do
    it "should update a price" do
      expect(Price.count).to eq 1
      put :update, params: { id: @price.id,
                             price: { id: @price.id,
                                     last: 12345 } }
      expect(Price.count).to eq 1
      @price.reload
    end

    it "should not update a price" do
      expect(Price.count).to eq 1
      put :update, params: { id: @price.id,
                             price: { id: @price.id,
                                     last: nil } }
      expect(Price.count).to eq 1
    end
  end

  describe "GET #show" do
    it "should get :show/:id" do
      get :show, params: { id: @price.id }
      expect(response).to be_successful
    end
  end

  describe "#destroy" do
    it "should delete price" do
      expect { delete :destroy, params: { id: @price.id } }.to change(
        Price,
        :count,
      ).by(-1)
      expect(flash[:notice]).to be_present
      expect(response).to redirect_to prices_path
    end

    it "should not delete price" do
      expect(Price.count).to eq 1
      allow_any_instance_of(Price).to receive(:destroy).and_return false
      expect { delete :destroy, params: { id: @price.id } }.
        to change(Price, :count).by(0)
      expect(flash[:error]).to be_present
      expect(response).to render_template "index"
    end
  end
end