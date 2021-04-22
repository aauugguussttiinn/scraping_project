require 'rubygems'
require 'nokogiri' 
require 'open-uri'


page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/").read)



def get_townhall_email(townhall_url)
    page = Nokogiri::HTML(URI.open(townhall_url).read)
    email = page.css('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    puts email
end


#get_townhall_email("http://www.annuaire-des-mairies.com/95/avernes.html")


def get_townhall_urls
    page = Nokogiri::HTML(URI.open("http://www.annuaire-des-mairies.com/val-d-oise.html").read)
    array = []
    n = 0
    array << urls = page.css('table.Style20 a.lientxt')[n]['href']
    while urls != "./95/wy-dit-joli-village.html"
        n += 1
        array << urls = page.css('table.Style20 a.lientxt')[n]['href']
    end
    clean_urls = array.map { |word| word.insert(0, 'http://www.annuaire-des-mairies.com/') }
    return clean_urls
end

def get_all_email(townhall_url)
    page = Nokogiri::HTML(URI.open(townhall_url).read)
    email = page.css('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    puts email
end

def all_townhalls_email
    city_mails = []
    get_townhall_urls.each do |getting|
        page = Nokogiri::HTML(URI.open(getting).read)
        city_mails << email = page.css('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    end
    return city_mails
end

def all_townhalls_names
    city_names = []
    get_townhall_urls.each do |getting|
        page = Nokogiri::HTML(URI.open(getting).read)
        city_names << name = page.css('strong a.lientxt4').text
    end
    return city_names
end



result = Hash[all_townhalls_names.zip(all_townhalls_email)]
print result