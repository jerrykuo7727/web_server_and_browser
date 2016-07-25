require 'socket'
require 'json'

host = 'localhost'
port = 2000
path = "/index.html"

print "Enter type of request: "
method = gets.chomp.upcase
request = case method
  when "GET"
    "#{method} #{path} HTTP/1.0\n"
  when "POST"
    print "Please enter your name: "
    name = gets.chomp
    print "Please enter your email: "
    email = gets.chomp
    puts

    data = { viking: {name: name, email: email} }.to_json
    puts "#{method} #{path} HTTP/1.0\nContent-Length: #{data.size}\n#{data}"
    "#{method} #{path} HTTP/1.0\nContent-Length: #{data.size}\n#{data}"
  end

socket = TCPSocket.open(host, port)
socket.puts(request)
response = socket.read
puts response