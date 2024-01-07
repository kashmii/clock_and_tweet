# frozen_string_literal: true

require_relative "timer"
require_relative "clock_and_tweet/version"

module ClockAndTweet
  class Error < StandardError; end
  timer = Timer.new

  loop do
    print "Enter a command (start, end, exit): "
    command = gets.chomp.downcase

    case command
    when 'start'
      timer.start
    when 'end'
      timer.end
    when 'exit'
      break
    else
      puts "Invalid command. Please enter 'start', 'end', or 'exit'."
    end
  end
end
