require 'socket'

server = TCPServer.open(2000)
loop {
  client = server.accept

  request = client.gets.chomp
  header = request.scan(/\S+/).flatten
  method = header[0]
  filename = header[1][1..-1] 
  protocol = header[2]

  puts request

  case method
  when 'GET'
    file_exists = File.exist?(filename)

    if file_exists
      client.puts "#{protocol} 200 OK"
      client.puts("Date: #{Time.now.ctime}")

      content = File.read(filename)
      client.puts "Content-Length: #{content.size}"
      client.puts
      client.puts content

    else
      client.puts "#{protocol} 404 Not Found"
      client.puts("Date: #{Time.now.ctime}")
    end

  when 'POST'
    puts client.gets
    puts
    data = client.gets.chomp
    puts data

    client.puts "#{protocol} 200 OK"
    client.puts("Date: #{Time.now.ctime}")
  else
    client.puts "#{protocol} 500 Unknown Method"
    client.puts("Date: #{Time.now.ctime}")
  end

  client.close
}