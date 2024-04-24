module Api
    class PricesController < ApplicationController
      protect_from_forgery with: :null_session
  
      def create
        capture_price(params[:product_id])
        head :no_content
      end
  
      def index
        @prices = Price.where("symbol IN (?,?)", 'BTCAUD', 'ETHAUD').order(timestamp: :desc)
       
        render json: @prices
      end
  
      private
  
      def capture_price(product_id)
        response = HTTParty.get("https://data.exchange.coinjar.com/products/#{product_id}/ticker")
        data = JSON.parse(response.body)
        Price.create!(symbol: data['product_id'], last: data['last'], bid: data['bid'], ask: data['ask'], timestamp: Time.now)
      end
    end
  end