# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name


# INSTALLATION

#
# email     = "xendaccount@xendacentral.com"
# password  = "xenda"
# 
# shell.say ""
# 
# account = Account.create(:email => email, :name => "Xenda", :surname => "Account", :password => password, :password_confirmation => password, :role => "admin")
# 
# if account.valid?
#   shell.say "================================================================="
#   shell.say "Account has been successfully created, now you can login with:"
#   shell.say "================================================================="
#   shell.say "   email: #{email}"
#   shell.say "   password: #{password}"
#   shell.say "================================================================="
# else
#   shell.say "Sorry but some thing went worng!"
#   shell.say ""
#   account.errors.full_messages.each { |m| shell.say "   - #{m}" }
# end
# 
# shell.say ""


# DATA CAPTURE

require 'rubygems'
require 'nokogiri'
require 'open-uri'

puts "Obteniend data de la Fifa"

@doc = Nokogiri::HTML(open("http://es.fifa.com/worldcup/matches/index.html"))

@doc.css(".fixture").each do |group_rows|

  puts "Creando grupos"
  # Group Name
  group_name = group_rows.attributes["summary"].value
  group = Group.create :name => group_name
  
  group_rows.css("tbody tr").each do |match|
    
    puts "Creando información de cada grupo, estadio, pais, equipo"
    match_number = match.css("td")[0].text
    date = match.css("td")[1].text
    date.gsub! (/(.*)\/(.*) (.*):(.*)/)  {"#{$2}/#{$1} #{$3}:#{$4}" }
    date = Date.parse(date)
    place = match.css("td")[2].text
    first_team = match.css("td")[4].text
    second_team = match.css("td")[6].text
    # puts "#{match_number}: #{date} En #{place} - #{first_team} vs #{second_team}"
    
    country = Country.find_or_create_by_name place
    one_country = Country.find_or_create_by_name first_team
    second_country = Country.find_or_create_by_name second_team
    
    stadium = country.stadia.find_or_create_by_name country.name
    
    first_team = Team.create :name => first_team, :country_id => one_country.id
    second_team = Team.create :name => second_team, :country_id => second_country.id
    
    Match.create :number => match_number, :played_at => date, :place => country.name, :stadium_id => stadium.id, :first_team_id=>first_team.id, :second_team_id => second_team.id, :group_id=>  group.id
    
  end
  
end


# User account creation

require 'faker'

puts "creando cuentas falsas"
1000.times do  
  
  puts "Creando a #{Faker::Name.name}"
  a = Account.create(:email => Faker::Internet.email, :name => Faker::Name.name, :surname => Faker::Name.last_name, :password=>"99999", :password_confirmation=>"99999", :role =>"user"  )
      # account = Account.create(:email => email, :name => "Xenda", :surname => "Account", :password => password, :password_confirmation => password, :role => "admin")
  
end

# shell.say "Creadas 1000 cuentas"

