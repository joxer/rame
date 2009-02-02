
if `which mongrel_rails`.chop == ""
  puts "install mongrel first\nif you have an a based debian distro install with:\n sudo apt-get install mongrel\nDon't get with gem."

else
  if `gem search erubis --local`.chop =~ /erubis/
    
    `sudo ruby server.rb`
  else
    puts "install with rubygems erubis"
  end
end
