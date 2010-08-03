require 'rubygems'
files = `ls`
# puts files.split("\n").inspect

shirts_m = files.select {|file| file=~/club_.*_shirt_1_m/ }
shorts_m = files.select {|file| file=~/short_.*_1_m/ }
snickers_m = files.select {|file| file=~/snickers_.*_1_m/ }
shoes_m = files.select {|file| file=~/shoes_1_m/ }
heads_m = files.select {|file| file=~/head_1_m/ }

shirts_f = files.select {|file| file=~/shirt_.*_1_f/ }
shorts_f = files.select {|file| file=~/short_.*_1_f/ }
snickers_f = files.select {|file| file=~/snickers_.*_1_f/ }
shoes_f = files.select {|file| file=~/shoes_1_f/ }
heads_f = files.select {|file| file=~/head_1_f/ }

def clean(name)
  
  [/_1_[mf]/, ".swf", "shirt", "short","snickers","head","shoes" ].each do |token| 
    name = name.gsub(token,"")
  end
  name = name.gsub("-","_")
  name = name.gsub("_", " ")
  name.strip!
end

xml_file = "<root>"
xml_file << "<group_shirt id=\"shirt\">"
i = 0
shirts_f.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
  i+=1
end
shirts_m.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>0</sex></item>"
  i+=1
end

xml_file << "</group_shirt>"
xml_file << "<group_shorts id=\"shorts\">"
i = 0
shorts_f.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
  i+=1
end
shorts_m.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>0</sex></item>"
  i+=1
end

xml_file << "</group_shorts>"
xml_file << "<group_snickers id=\"snickers\">"
i = 0
snickers_f.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
  i+=1
end
snickers_m.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>0</sex></item>"
  i+=1
end

xml_file << "</group_snickers>"
xml_file << "<group_shoes id=\"shoes\">"
i = 0
shoes_f.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
  i+=1
end
shoes_m.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>0</sex></item>"
  i+=1
end

xml_file << "</group_shoes>"
xml_file << "<group_head id=\"head\">"
i = 0
heads_f.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>1</sex></item>"
  i+=1
end
heads_m.each do |shirt|
  name = clean(shirt)
  xml_file << "<item><id>#{i+1}</id><name>#{name}</name><picture_file_name>#{shirt}</picture_file_name><sex>0</sex></item>"
  i+=1
end

xml_file << "</group_head>"
xml_file << "</root>"

puts xml_file