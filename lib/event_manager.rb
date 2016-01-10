require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number
  contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
  contents.each do |row|
    phone = row[:homephone]
    if phone.length < 10
      phone = "bad_number"
    elsif phone.length == 11
      if phone[0] == 1
        phone = phone.to_a.shift
        phone = phone.to_s
        puts phone
      else
        phone = "bad number"
      end
    else
      puts phone
  end
  
# def clean_phone_number(homephone)
#   homephone.to_s.rjust(10,"0")[0..9]
#
# end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open '/Users/marinacorona/Turing/Module1/event_manager/lib/event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "/Users/marinacorona/Turing/Module1/event_manager/form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)
end


require "csv"
puts "EventManager initialized."



end
