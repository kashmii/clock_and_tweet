require 'net/http'
require 'json'
require './vendor/bundle/ruby/3.0.0/gems/x-0.14.1/lib/x'

class Timer
  attr_accessor :start_time, :end_time, :comment

  # 1
  def start
    @start_time = Time.now
    puts "Timer started at #{@start_time}"
  end

  # 2
  def end
    @end_time = Time.now
    puts "Timer ended at #{@end_time}"
    comment_input
  end

  # 3
  def comment_input
    print "Enter a comment (100 characters or less. Press enter to skip): "
    @comment = gets.chomp
    show_confirmation
  end

  # 4
  def show_confirmation
    puts "Time: #{duration} seconds"
    puts "Comment: #{@comment}"
    print "Do you confirm? (Type 'ok' or 'no'): "
    response = gets.chomp.downcase
    handle_confirmation(response)
  end

  # 5
  def handle_confirmation(response)
    case response
    when 'ok'
      show_result
    when 'no'
      reset
      puts "Measurement and comment discarded. Back to initial state."
    else
      puts "Invalid response. Please type 'ok' or 'no'."
      show_confirmation
    end
  end

  # 6
  def show_result
    x_credentials = {
      api_key:             ENV['X_API_KEY'],
      api_key_secret:      ENV['X_API_KEY_SECRET'],
      access_token:        ENV['X_ACCESS_TOKEN'],
      access_token_secret: ENV['X_ACCESS_TOKEN_SECRET'],
    }

    x_client = ::X::Client.new(**x_credentials)
    puts x_client.base_url

    begin
      tweet = x_client.post("tweets", "Hello, World! (from x-ruby gem)")

    rescue StandardError => e
      puts "An error occurred: #{e.message}, code: #{e.code}, response: #{e.response}"
    end
  end

  # 7
  def reset
    @start_time = nil
    @end_time = nil
    @comment = nil
  end

  # 8
  def duration
    return 0 unless @start_time && @end_time

    (@end_time - @start_time).round(2)
  end
end
