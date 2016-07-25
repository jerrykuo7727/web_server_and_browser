require 'socket'
require 'json'

host = 'localhost'
port = 2000

print "Enter type of request: "
method = gets.chomp.upcase
request = case method
  when "GET"
    path = "/index.html"
    puts
    "#{method} #{path} HTTP/1.0\n"

  when "POST"
    print "Please enter your name: "
    name = gets.chomp
    print "Please enter your email: "
    email = gets.chomp
    puts

    path = "/thanks.html"
    data = {:viking => {:name => name, :email => email}}.to_json
    "#{method} #{path} HTTP/1.0\nContent-Length: #{data.size}\n#{data}"
  else
    "#{method} HTTP/1.0"
  end

socket = TCPSocket.open(host, port)
socket.puts(request)
response = socket.read
puts response