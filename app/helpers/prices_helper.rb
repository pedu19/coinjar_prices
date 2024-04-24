module PricesHelper
  def fetch_and_capture_price_bt(btcaud)
    response = HTTParty.get("https://data.exchange.coinjar.com/products/BTCAUD/ticker", query: { foo: 'bar' })
    data = JSON.parse(response.body)
    Price.create!(
      symbol: btcaud,
      last: data['last'],
      bid: data['bid'],
      ask: data['ask'],
      change_24h: data['change_24h'],
      current_time: data['current_time'],
      prev_close: data['prev_close'],
      session: data['session'],
      status: data['status'],
      transition_time: data['transition_time'],
      volume: data['volume'],
      volume_24h: data['volume_24h'],
      timestamp: Time.now
    )
    end
  def fetch_and_capture_price_et(ethaud)
    response = HTTParty.get("https://data.exchange.coinjar.com/products/ETHAUD/ticker")
    data = JSON.parse(response.body)
    Price.create!(
      symbol: ethaud,
      last: data['last'],
      bid: data['bid'],
      ask: data['ask'],
      change_24h: data['change_24h'],
      current_time: data['current_time'],
      prev_close: data['prev_close'],
      session: data['session'],
      status: data['status'],
      transition_time: data['transition_time'],
      volume: data['volume'],
      volume_24h: data['volume_24h'],
      timestamp: Time.now
    )
    end
end
