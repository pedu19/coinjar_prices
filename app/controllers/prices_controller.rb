class PricesController < ApplicationController
  
  require 'httparty'
  # require 'json'
  layout "price"
  include PricesHelper
  def index
    btcaud = "BTCAUD"
    ethaud = "ETHAUD"
    @btc_prices = Price.where(symbol: 'BTCAUD').first || fetch_and_capture_price_bt(btcaud).order("created_at desc")
    @eth_prices = Price.where(symbol: 'ETHAUD').first|| fetch_and_capture_price_et(ethaud).order("created_at desc")
    @prices = @btc_prices, @eth_prices
  end

  def history
    @price = Price.find(params[:id])
    if @price.symbol == 'BTCAUD'
      @prices = Price.where(symbol: 'BTCAUD').order(timestamp: :desc)
    else
      @prices = Price.where(symbol: 'ETHAUD').order(timestamp: :desc)
    end
  end

  def capture
    capture_price('BTCAUD')
    capture_price('ETHAUD')
    redirect_to root_path
  end

  def new
    @price = Price.new
  end

  def create
    @price = Price.new(price_params)
    if @price.save
      flash[:notice] = "Price created successfully"
      redirect_to prices_path
    else
      flash[:error] = "Something went wrong"
      render "new"
    end
  end

  def edit
    @price = Price.find(params[:id])
  end

  def update
    @price = Price.find(params[:id])
    if @price.update(price_params)
      flash[:notice] = "price updated successfully"
      redirect_to prices_path
    else
      flash[:error] = "Something went wrong"
      render "edit"
    end
  end

  def show
    @price = Price.find(params[:id])
  end

  def destroy
    @price = Price.find(params[:id])
    if @price.destroy
      flash[:notice] = "Price was deleted successfully"
      redirect_to prices_path
    else
      flash[:error] = "Something went wrong"
      render "index"
    end
  end


  private
  def price_params
    params.require(:price).permit(:id, :symbol, :last, :bid, :ask, :change_24h, :current_time, :prev_close, :session, :status, :transition_time, :volume, :volume_24h)

  end
  def capture_price(product_id)
    response = HTTParty.get("https://data.exchange.coinjar.com/products/#{product_id}/ticker")
    data = JSON.parse(response.body)
    Price.create!(symbol: data['product_id'], last: data['last'], bid: data['bid'], ask: data['ask'], timestamp: Time.now)
  end

end
