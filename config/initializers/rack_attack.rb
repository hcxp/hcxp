# Rack::Attack.throttle('req/ip', limit: 1000, period: 1.hour) do |req|
#   # If the return value is truthy, the cache key for the return value
#   # is incremented and compared with the limit. In this case:
#   #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
#   #
#   # If falsy, the cache key is neither incremented nor checked.
#   req.ip unless req.path.starts_with?('/assets')
# end

Rack::Attack.throttle('req/ip/sec', limit: 1, period: 1.second) do |req|
  req.ip unless req.path.starts_with?('/assets')
end

Rack::Attack.throttled_response = lambda do |env|
  Rails.logger.warn "Throttled request."
  [ 429, {}, ["Throttled\n"]]
end
