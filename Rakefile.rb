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
    r.push("\n end\nend")
    s.puts r.join
   
    s.close
    
  end
end
