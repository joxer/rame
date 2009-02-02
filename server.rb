 #require 'rubygems'
 require 'mongrel'
 #require 'erubis'
 require 'erb'
class Erba
 
  def initialize(method)
    
    @method = method
    
    @file = File.read("erubis_html/#{@method}.eruby")
    end
  
  def run
    @testo = ""
    @uh = ERB.new(@file)
    @uh.result
  end
end

 include Mongrel;
 
 class Handler < HttpHandler
   def process(request, response)
     response.start(200) do |head,out|
       method =  request.params["REQUEST_PATH"].to_s
       head["Content-Type"] = "text/html"
       
       out.write(Erba.new("time").run) if method =~ /:time/
       out.write(Erba.new("hello").run) if method =~ /:hello/
     end
   end
 end
 
 h = HttpServer.new("0.0.0.0", "80")
 
 h.register('/', DirHandler.new(".", true, 'index.html'))
 h.register('/method', Handler.new)
 h.run.join

