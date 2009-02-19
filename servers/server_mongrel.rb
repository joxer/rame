 require 'mongrel'
 require 'erb'
 require 'Classes/Core/Controller.rb'
 require 'Classes/stdlib/socket.rb'
 require 'Classes/Core/File.rb'
 include Mongrel;
 
#handler the http request for generic method

 class Handler < HttpHandler
   def process(request, response)
     response.start(200) do |head,out|
       method =  request.params["REQUEST_PATH"].to_s
       head["Content-Type"] = "text/html"
       g = Controller.new
       method = method.split("/method/:")[1]
       out.write(g.method(method).call)

       
     end
   end
 end

#handler the http request for Socket method

 class Socket_Handler < HttpHandler
   def process(request, response)
     response.start(200) do |head,out|
       method =  request.params["REQUEST_PATH"].to_s
       head["Content-Type"] = "text/html"
       d = method.split("/method/socket/:")[1].split("+") #d[0] = get ; d[1] = url
 
       s = Socket.new(d[1])
       
       out.write(s.method(d[0]).call)
       
       
     end
   end
 end

 
 class File_Handler < HttpHandler
   def process(request, response)
     response.start(200) do |head,out|
       method =  request.params["REQUEST_PATH"].to_s
       head["Content-Type"] = "text/html"
       d = method.split("/file/:")[1].split("+") #d[0] = read ; d[1] = file
  
       s = Files.new(d[1])
       
       out.write(s.method(d[0]).call)
       
       
     end
   end
 end
 h = HttpServer.new("0.0.0.0", "3000")
 
 #varius url

 h.register('/', DirHandler.new("public_html", true, 'index.html'))
 h.register('/method', Handler.new)
 h.register('/method/socket', Socket_Handler.new)
 h.register('/file', File_Handler.new)
 #h.register('/test', DirHandler.new("test", true, 'index.html'))
 h.run.join

