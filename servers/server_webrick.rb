require 'webrick'
require 'rubygems'
require 'erubis'
require 'Classes/Erb_handler'
require 'Classes/Method'
include WEBrick
puts `pwd`
class Handler < HTTPServlet::AbstractServlet
  def do_POST(req, res)
    p req.path
    m = req.path.split("/method/:")[1]
    res.body = GMethod.new.method(m).call
    res['Content-Type'] = "text/html"
  end
end


a = HTTPServer.new(:Port => 3000)
a.mount("/method", Handler)
a.mount("/", HTTPServlet::FileHandler, "./public_html/", true)
a.mount("/test", HTTPServlet::FileHandler, "./test/", true)
trap("INT"){ a.shutdown }

a.start
