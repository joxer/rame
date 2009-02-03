require 'yaml'
require 'rake'


y = YAML::load(File.new("method.yml"))

task :default => :add

task :add do
  r = Array.new
  File.open("Classes/GMethod.rb", "r") do |s|
    r = s.readlines
  end
  
  for i in y
    
      File.open("m/#{i}.eruby", "w") do |s|
        s.puts "<!-- no comment -->"
      s.close
      
    end
    

  end
  
  
  File.open("Classes/GMethod.rb", "w") do |s|
    r.pop if r[-1] =~ /end/
    r.pop if r[-2] =~ /end/
    for i in y
      r.push("\n\n  def #{i}\n\n  end")
    end
    r.push("\n end")
    s.puts r.join
    
    s.close
    
  end
end


task :remove do
  lines = Array.new
  File.open("Classes/GMethod.rb", "r") do |s|
    lines = s.readlines
    0.upto(lines.length - 1) do |f|
      for i in y do 
        
        if lines[f].match("def #{i}") != nil
          lines[f] = ""
          f.upto(lines.length - 1) do |q|
      
            if lines[q].match("end") != nil
              lines[q] = ""
              break
            end
          end
        end   
        if lines[f].match("#{i}") != nil
         
            lines[f] = ""
        end
      end
    end
    s.close
  end
  
  File.open("Classes/GMethod.rb", "w") do |s|

    s.puts lines.join.gsub("\n\n", "")
    s.close
  end

  for i in y
    begin

      ` rm m/#{i}.eruby`
    rescue
     
    end

  end

end
