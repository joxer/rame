require 'yaml'
require 'rake'
require 'sqlite3'
require 'fileutils'

method = ENV['method']
version = ENV['version']


 task :default do
    puts "puts rake --task to see avaible tasks"
  end
  


namespace :method do
  
  desc "This task add method contained into method.yml to Classes/Gmethod.rb"
  task :add do
    raise ("no input") if method == nil 
    readed = IO.readlines("Classes/Method.rb")
    

    
   
    File.open("m/#{method}.eruby", "w") do |s|
      s.puts "<!-- no comment -->"
      s.close
    end
    
    
    File.open("Classes/Method.rb", "w") do |s|
      readed.pop if readed[-1] =~ /end/
      readed.pop if readed[-2] =~ /end/
      
      readed.push("\n\n  def #{method}\n\n\nreturn Erb_Handler.new('#{method}').run\n\n  end\n end\n")
      s.puts readed.join
      
      s.close
      
    end
  end
  desc "This task remove method contained into method.yml to Classes/Gmethod.rb"
  task :remove do
    raise ("no input") if method == nil
    lines = Array.new
    File.open("Classes/Method.rb", "r") do |s|
      lines = s.readlines.join
      lines = lines.gsub(/def #{method}.*\s*return.*\s*.end/, "")
    end
    File.open("Classes/Method.rb", "w") {|s| s.puts lines; s.close}
    rm("m/#{method}.eruby")
  end
end

namespace :db do
  
  desc "This task add a version of Method.rb into the database"
  task :ver_add do 
    raise ("no input") if  version == nil
    file = IO.readlines("Classes/Method.rb").join.to_s
    db = SQLite3::Database.new("sqlite/method.db")
    db.execute("insert into method(file, date) values('#{file}', '#{Time.new}')")
    db.close
  end
  
  desc "This task remove a version of Method.rb into the database, use the variable version= to set the version"
  task :ver_rem do 
    raise ("no input") if version == nil
    if version == nil
      puts "insert a valid number"
    else
      
      db = SQLite3::Database.new("sqlite/method.db")
      db.execute("delete from method where id = #{version}")
      db.close
      puts "version removed"
      
    end
  end
  desc "This task show a version of Method.rb into the database"
  task :ver_show do 
    raise ("no input") if version == nil
    if version == nil
      puts "insert a valid number"
    else
      
      db = SQLite3::Database.new("sqlite/method.db")
      db.execute("select file from method where id = #{version}") {|s| puts s}
      db.close
      
    end
  end
end
