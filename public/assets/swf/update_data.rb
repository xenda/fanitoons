require 'rubygems'
files = `ls`
# puts files.split("\n").inspect

shirts = files.select {|file| file=~/shirt_1_f/ }
shorts = files.select {|file| file=~/short_1_f/ }
snickers = files.select {|file| file=~/snicker_1_f/ }

xml_file = "<root>"
xml_file << "<group_shirt>"
shirts.each_with_index do |shirt,i|
  name = shirt.split("_").first
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
end

xml_file << "</group_shirt>"
xml_file << "<group_shorts>"
shorts.each_with_index do |shirt,i|
  name = shirt.split("_").first
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
end
xml_file << "</group_shorts>"
xml_file << "<group_snickers>"
snickers.each_with_index do |shirt,i|
  name = shirt.split("_").first
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
end
xml_file << "</group_snickers>"

xml_file << "</root>"

puts xml_file