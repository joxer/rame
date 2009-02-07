class Modify

  def initialize(name)

    @name = name
    @file = File.new("m/#{name}.eruby", "r+")
    @read = @file.readlines.join
    
  end

  def transform
    
    links = @read.scan(/:link_to.*/)
    
    for i in links
      h = i.gsub(":link_to", "").split(";")
    
      i = "<a href='#{h[0].strip}'>#{h[1]}</a>"
    
      @read.gsub!(/:link_to.*/, i)
    end
    
    @file.close
    @file = File.open("m/#{@name}.eruby", "w") do |w|
      puts @read
      w.puts @read
      w.close
    end
  end
  

end
