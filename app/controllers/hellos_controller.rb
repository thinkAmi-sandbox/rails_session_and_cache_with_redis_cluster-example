class HellosController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  def index
    session_timestamp = session[:session_timestamp]
    cache_timestamp = Rails.cache.read("cache_timestamp")

    puts session_timestamp
    puts cache_timestamp

    render json: {
      current_timestamp: Time.current.strftime("%Y/%m/%d %H:%M:%S"),
      session_timestamp:,
      cache_timestamp:
    }
  end

  def create
    now = Time.current.strftime("%Y/%m/%d %H:%M:%S")
    session[:session_timestamp] = "session -> #{now}"
    Rails.cache.write("cache_timestamp", "cache -> #{now}")

    head :ok
  end
end
