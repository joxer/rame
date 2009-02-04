require 'net/http'
require 'uri'
class Socket

  def initialize(host)
    
    @host = host

  end
  
  def get
    
  
  

    
    
    return Net::HTTP.get URI.parse("#{@host}")

    
  end


end
