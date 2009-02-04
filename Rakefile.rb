require 'yaml'
require 'rake'
require 'sqlite3'

y = YAML::load(File.new("method.yml"))

 task :default do
    puts "puts rake --task to see avaible tasks"
  end
  

namespace :method do
   
  desc "This task add method contained into method.yml to Classes/Gmethod.rb"
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
  
  desc "This task remove method contained into method.yml to Classes/Gmethod.rb"
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
  
end

namespace :db do
  
  desc "This task add a version of GMethod.rb into the database"
  task :ver_add do 
    file = ""
    File.open("Classes/GMethod.rb", "r") do |s|
      file = s.readlines.join.to_s
      s.close
    end
    
    db = SQLite3::Database.new("sqlite/method.db")
    db.execute("insert into method(file, date) values('#{file}', '#{Time.new}')")
    db.close
  end
  
  desc "This task remove a version of GMethod.rb into the database, use the variable version= to set the version"
  task :ver_rem do 
    
    if ENV['version'] == nil
      puts "insert a valid number"
    else
      
      db = SQLite3::Database.new("sqlite/method.db")
      db.execute("delete from method where id = #{ENV['version']}")
      db.close
      puts "version removed"
      
    end
  end
  desc "This task show a version of GMethod.rb into the database"
  task :ver_show do 
    
    if ENV['version'] == nil
      puts "insert a valid number"
    else
      
      db = SQLite3::Database.new("sqlite/method.db")
      db.execute("select file from method where id = #{ENV['version']}") {|s| puts s}
      db.close
      
    end
  end
end
