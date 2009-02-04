require 'rubygems'
require 'active_record'
require 'yaml'


puts home[0]
class Connect
  def initialize(file)
    ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => '#{home[0]}/sqlite/database.db')
  end
end

