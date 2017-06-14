class GraphqlController < ApplicationController
  # after_action :set_ratelimit_headers

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    context = {
      # Query context goes here, for example:
      current_user: current_user,
    }
    result = HcxpSchema.execute(query, variables: variables, context: context)
    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def set_ratelimit_headers
    now = Time.now
    match_data = env['rack.attack.throttle_data']

    limit     = match_data['req/ip'][:limit]
    remaining = match_data['req/ip'][:limit] - match_data['req/ip'][:count]
    reset     = now + (match_data['req/ip'][:period] - now.to_i % match_data['req/ip'][:period])

    response.headers['X-RateLimit-Limit']     = limit.to_s
    response.headers['X-RateLimit-Remaining'] = remaining.to_s
    response.headers['X-RateLimit-Reset'] =     reset.to_s
  end
end
