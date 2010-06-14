require 'rubygems'
files = `ls`
# puts files.split("\n").inspect

shirts_m = files.select {|file| file=~/shirt_1_m/ }
shorts_m = files.select {|file| file=~/short_1_m/ }
snickers_m = files.select {|file| file=~/snicker_1_m/ }

shirts_f = files.select {|file| file=~/shirt_1_f/ }
shorts_f = files.select {|file| file=~/short_1_f/ }
snickers_f = files.select {|file| file=~/snicker_1_f/ }

xml_file = "<root>"
xml_file << "<group_shirt>"
i = 0
shirts_f.each do |shirt|
  name = shirt.split("_").first
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
  i+=1
end
shirts_m.each do |shirt|
  name = shirt.split("_").first
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>0</sex></item>"
  i+=1
end

xml_file << "</group_shirt>"
xml_file << "<group_shorts>"
i = 0
shorts_f.each do |shirt|
  name = shirt.split("_").first
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
  i+=1
end
shorts_m.each do |shirt|
  name = shirt.split("_").first
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>0</sex></item>"
  i+=1
end

xml_file << "</group_shorts>"
xml_file << "<group_snickers>"
i = 0
snickers_f.each do |shirt|
  name = shirt.split("_").first
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
  i+=1
end
snickers_m.each do |shirt|
  name = shirt.split("_").first
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>0</sex></item>"
  i+=1
end

xml_file << "</group_snickers>"

xml_file << "</root>"

puts xml_file