class GMethod
  
  def initialize
  
    
  end
  
  def time
    
    return Erb_Handler.new("time").run
    
  end
  
  
  def alert_hello
    return Erb_Handler.new("alert_hello").run
  end
  
  def alert_time
    return Erb_Handler.new("alert_time").run
  end
    
     end
