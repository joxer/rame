require 'yaml'
File.open("conf/home.yml", "w") do |s|
  
YAML.dump( [`pwd`.chop], s)

end
