require 'yaml'
require 'rake'
require 'sqlite3'
require 'fileutils'

i = ENV['method']

 task :default do
    puts "puts rake --task to see avaible tasks"
  end
  


namespace :method do
   
  desc "This task add method contained into method.yml to Classes/Gmethod.rb"
  task :add do
    r = Array.new
    File.open("Classes/Method.rb", "r") do |s|
      r = s.readlines
    end
    
   
      File.open("m/#{i}.eruby", "w") do |s|
        s.puts "<!-- no comment -->"
        s.close
        
          

    end
    
    
    File.open("Classes/Method.rb", "w") do |s|
      r.pop if r[-1] =~ /end/
      r.pop if r[-2] =~ /end/
      
      r.push("\n\n  def #{i}\n\n\nreturn Erb_Handler.new('#{i}').run\n\n  end\n end\n")
      s.puts r.join
      
      s.close
      
    end
  end
  desc "This task remove method contained into method.yml to Classes/Gmethod.rb"
  task :remove do
    lines = Array.new
    File.open("Classes/Method.rb", "r") do |s|
      lines = s.readlines.join
      lines = lines.gsub(/def #{i}.*\s*return.*\s*.end/, "")
    end
    File.open("Classes/Method.rb", "w") {|s| s.puts lines; s.close}
    rm("m/#{i}.eruby")
  end
end

namespace :db do
  
  desc "This task add a version of Method.rb into the database"
  task :ver_add do 
    file = ""
    File.open("Classes/Method.rb", "r") do |s|
      file = s.readlines.join.to_s
      s.close
    end
    
    db = SQLite3::Database.new("sqlite/method.db")
    db.execute("insert into method(file, date) values('#{file}', '#{Time.new}')")
    db.close
  end
  
  desc "This task remove a version of Method.rb into the database, use the variable version= to set the version"
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
  desc "This task show a version of Method.rb into the database"
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
