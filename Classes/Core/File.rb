

class Files
  
  def initialize(file)
    p file
    @file = file

  end
  
  def read

    File.open("file/#{@file}", "r") do |s|
      
      return s.readlines.join("")

    end
      
      
  end
  
end
