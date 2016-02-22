require 'pry'
require 'socket'
require_relative 'distributor'
class Server
  def initialize
    @count = 0
  end

  def server_start #we read request from client
    tcp_server = TCPServer.new(9292)
    client = tcp_server.accept
    loop do
      request(client)
    end
  end
    #when the program runs, it'll hang on that gets method call waiting
    #for a request to come in. When it arrives it'll get read
    #and stored into request_lines
    def request(client)   #store all request lines in array
    puts "Ready for a request"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    distributor = Distributor.new
    @response = distributor.process_request(request_lines, @count)

    print_response(@response, client)

  end

  def print_response(request_lines, client)
    @count +=1
    puts "Got this request:"
    puts request_lines.inspect
    #print response
    puts "Sending response."
    binding.pry

    client.puts @response.last
    client.puts @response.first
    #close server
    puts ["Wrote this response:", @response.last, @response.first].join("\n")
    # client.close
    # puts "\nResponse complete, exiting."
  end
end

s = Server.new
s.server_start
