require 'Classes/Core/Transform'

class Controller

  def initialize
    
  end

  
  
  def cacca
    Modify.new("cacca").transform
    
    

    return Erb_Handler.new('cacca').run
    
  end


  def os_type

    
    return Erb_Handler.new('os_type').run

  end


  def server_type


return Erb_Handler.new('server_type').run

  end
 end
