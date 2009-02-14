class Erb_Handler
 
  def initialize(method)
    
    @method = method
    
    @file = File.read("m/#{@method}.eruby")
    end
  
  def run
    
    @testo = ""
    @uh = ERB.new(@file)
    @uh.result
  end
end
