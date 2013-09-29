require 'nokogiri'
require 'open-uri'

BASE = "http://pragprog.com/magazines"

1.upto(5) do |i|
  doc = Nokogiri::HTML(open(BASE + "?page=#{i}"))
  rows = doc.css('table tr')
  rows.each do |row|
    title = row.at('h3').text.strip
    puts title
    links = row.css('a')
    links.each do |link|
      next if link.text == 'HTML'
      href = link[:href].downcase
      puts "#{link.text} = #{href}"
      `wget #{href}`
    end
  end
end
