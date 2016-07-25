require 'socket'

server = TCPServer.open(2000)
loop {
  client = server.accept

  request = client.gets.scan(/^(\S+) (\S+) (\S+)/).flatten
  method = request[0]
  filename = request[1][1..-1] 
  protocol = request[2]

  case method
  when 'GET'
    file_exists = File.exist?(filename)

    if file_exists
      client.puts "#{protocol} 200 OK"
      client.puts("Date: #{Time.now.ctime}")

      content_type = filename.scan(/\w+$/)[0]
      client.puts "Content-Type: #{content_type}"

      content = File.read(filename)
      client.puts "Content-Length: #{content.size}"
      client.puts
      client.puts content

    else
      client.puts "#{protocol} 404 Not Found"
      client.puts("Date: #{Time.now.ctime}")
    end

  else
    client.puts "#{protocol} 500 Unknown Method"
    client.puts("Date: #{Time.now.ctime}")
  end

  client.close
}