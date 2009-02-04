require 'sqlite3'
require 'activerecord'
require 'models'

class Query

  def initialize

#    @yaml_file = "databases/method.yml"
#    @sqlite_file = "database/method.db"
 
    ActiveRecord::Base.establish_connection( :adapter => 'sqlite', :dbfile => '/databases/method.db')

    
   
  end

  def query_sqlite(what, type, *values)



  end



end
