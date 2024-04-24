# frozen_string_literal: true

require 'machinist/active_record'
Price.blueprint do
  last { 100.0 }
  bid { 99.0 }
  ask { 101.0 }
  change_24h { 0.5 }
  current_time { "2024-04-15T02:29:03.213210Z" }
  prev_close { 105.0 }
  session { 66940 }
  status { "continuous" }
  transition_time { "2024-04-15T07:50:00Z" }
  volume { 29.504576629 }
  volume_24h { 152.967150728 }
  timestamp { Time.now }
end