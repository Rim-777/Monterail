require 'em-websocket'

EM.run {
  EM::WebSocket.run(:host => "127.0.0.1", :port => 9000) do |ws|
    ws.onopen { |handshake|
      puts "WebSocket connection open"

      ws.send "the server has confirmed the connection by url: #{handshake.path}"
    }
    ws.onclose { puts "Connection closed" }

    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"
      ws.send "Pong: #{msg}"
    }
  end
}
