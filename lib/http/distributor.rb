require_relative 'html_generator'
require_relative 'header_generator'
require_relative 'request_parser'
require_relative 'word_search'
require_relative 'game'
require_relative 'output_generator'
require_relative 'path'
require 'pry'

module HTTP
  class Distributor
    include HTMLGenerator
    include HeaderGenerator
    include OutputGenerator

    attr_reader :header, :output, :total_requests, :request

    def initialize
      @path = Path.new
      @request
      @header
      @total_requests = 0
      @output
    end

    def redirect_request(request_hash)
      @total_requests += 1
      @request = request_hash
      if @request[:path] == '/'
        output = @path.get_path_root(@request)
      elsif @request[:path] == '/hello'
        output = @path.get_path_hello
      elsif @request[:path] == '/datetime'
        output = @path.get_path_datetime
      elsif @request[:path] == '/shutdown'
        output = @path.get_path_shutdown(@total_requests)
      elsif @request[:path] == '/word_search'
        output = @path.get_path_word_search(request)
      elsif @request[:path] == '/start_game'
        output = @path.get_path_start_game
      elsif @request[:path] == '/game'
        output = @path.get_path_game(request)
      else
        output = @path.get_path_not_found
      end
      #binding.pry
      generate_output(output, @path.status_code)
    end

    def generate_output(output, status_code = "200 OK")
      @output = generate_html(output)
      @header = generate_header(@output.length, status_code)
      #binding.pry
    end
  end
end
