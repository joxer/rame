require 'Classes/Core/Transform'
require 'Classes/Core/Db'
require 'Classes/models'
class Controller

  def initialize
    
  end

  
  
  def j

    return Joxer.find(1)
  end


  def os_type
    

    
    
    return Erb_Handler.new('os_type').run

  end


  def server_type


return Erb_Handler.new('server_type').run

  end


  



  


  


  
 end
