require 'em-websocket'
require 'em-hiredis'

EM.run do

    @channel = EM::Channel.new

    @redis = EM::Hiredis.connect
    puts 'subscribing to redis'
    @redis.subscribe
    @redis.on(:message){|channel, message|
      puts "redis -> #{channel}: #{message}"
      @channel.push message
    }

    # Creates a websocket listener

  EM::WebSocket.run(:host => "127.0.0.1", :port => 9000) do |ws|
    ws.onopen { |handshake|
      puts "WebSocket connection open"

      # Access properties on the EM::WebSocket::Handshake object, e.g.
      # path, query_string, origin, headers

      # Publish message to the client
      ws.send "Hello Client, you connected to #{handshake.path}"
    }

    ws.onclose { puts "Connection closed" }

    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"
      @channel.push msg
      ws.send "Pong: #{msg}"
    }
  end
end