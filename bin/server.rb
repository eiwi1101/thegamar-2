require 'em-websocket'
require_relative '../thegamar'

EM.run do
  EM::WebSocket.run host: '0.0.0.0', port: 8989 do |ws|
    player = nil

    ws.onopen do |handshake|
      puts "Websocket open:"

      player = Player.new name: "Repl"

      player.on_prompt do |prompt|
        message = { type: 'PROMPT', message: prompt }
        ws.send message.to_json
      end

      message = { type: 'SERVER', message: "WELCOME" }.to_json
      ws.send message
    end

    ws.onclose do
      puts "Client closed."
    end

    ws.onmessage do |message|
      begin
        Command.parse player, message
      rescue GameError => e
        ws.send({type: 'ERROR', message: e.message}.to_json)
      end
    end
  end
end
