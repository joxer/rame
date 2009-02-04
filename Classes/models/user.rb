#require 'Classes/stdlib/database.rb'
require 'rubygems'
require 'active_record'

home = YAML::load(File.open("conf/home.yml"))
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'sqlite/database.db')

class User < ActiveRecord::Base
  
  def add
    
    a = self.new
    a.user = 
  end

end
