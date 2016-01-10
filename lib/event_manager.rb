require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

  def clean_zipcode(zipcode)
    contents = CSV.open '/Users/marinacorona/Turing/Module1/event_manager/lib/event_attendees.csv', headers: true, header_converters: :symbol
    contents.each do |row|
      name = row[:first_name]
      zipcode = row[:zipcode]
      if zipcode.nil?
        zipcode = "00000"
      elsif zipcode.length < 5
        zipcode = zipcode.rjust 5, "0"
      elsif zipcode.length > 5
        zipcode = zipcode[0..4]
      end
    puts "#{name} #{zipcode}"
    end
  end

  def clean_phone_number
    contents = CSV.open '/Users/marinacorona/Turing/Module1/event_manager/lib/event_attendees.csv', headers: true, header_converters: :symbol
      contents.each do |row|
        phone = row[:homephone]
        puts "#{phone}"
      end
      if phone.include?("()")
        phone = phone.delete("()")
      end
      if phone.include?("-")
        phone = phone.delete("-")
      end
      if phone.length == 11
        if phone[0] == 1
          phone = phone.to_a.shift
          phone = phone.to_s
        else
          phone = "bad number"
        end
      elsif phone.length == 10
         phone = phone
      else
        phone = "bad number"
      end
      puts "#{phone}"
    end


  def peak_hours
    contents = CSV.open '/Users/marinacorona/Turing/Module1/event_manager/lib/event_attendees.csv', headers: true, header_converters: :symbol
    contents.each do |row|
      time = row[:regdate]
    puts time
    end
  end

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


  template_letter = File.read "/Users/marinacorona/Turing/Module1/event_manager/form_letter.erb"
  erb_template = ERB.new template_letter
  contents = CSV.open '/Users/marinacorona/Turing/Module1/event_manager/lib/event_attendees.csv', headers: true, header_converters: :symbol

  contents.each do |row|
    id = row[0]
    name = row[:first_name]
    puts row[:homephone]

  end
