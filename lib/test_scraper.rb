require 'rubygems'
require 'nokogiri' 
require 'open-uri'


page = Nokogiri::HTML(open("http://ruby.bastardsbook.com/files/hello-webpage.html"))

puts page.css('title')
puts page.css("title")[0].name
puts page.css("title")[0].text