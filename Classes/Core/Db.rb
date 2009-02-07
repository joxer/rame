require 'rubygems'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection( 
 :adapter => 'sqlite3',
  :dbfile => 'sqlite/method.db' )


