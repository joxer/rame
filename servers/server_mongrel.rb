 #require 'rubygems'
 require 'mongrel'
 #require 'erubis'
 require 'erb'
 require 'Classes/GMethod'
 require 'Classes/Erb_handler'
 require 'Classes/stdlib/socket.rb'
 include Mongrel;
 
 class Handler < HttpHandler
   def process(request, response)
     response.start(200) do |head,out|
       method =  request.params["REQUEST_PATH"].to_s
       head["Content-Type"] = "text/html"
       g = GMethod.new
       method = method.split("/method/:")[1]
       out.write(g.method(method).call)

       
     end
   end
 end

 class Socket_Handler < HttpHandler
   def process(request, response)
     response.start(200) do |head,out|
       method =  request.params["REQUEST_PATH"].to_s
       head["Content-Type"] = "text/html"
       d = method.split("/method/socket/:")[1].split("+")
       p method
       s = Socket.new(d[1])
       
       out.write(s.method(d[0]).call)
       
       
     end
   end
 end
 h = HttpServer.new("0.0.0.0", "3000")
 
 h.register('/', DirHandler.new("public_html", true, 'index.html'))
 h.register('/method', Handler.new)
 h.register('/method/socket', Socket_Handler.new)
 h.register('/test', DirHandler.new("test", true, 'index.html'))
 h.run.join

