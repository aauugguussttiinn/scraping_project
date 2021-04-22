require 'rubygems'
require 'nokogiri' 
require 'open-uri'


page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/").read)   


array_symbol = []
y = 0
array_symbol << element = page.css('table td.cmc-table__cell.cmc-table__cell--sortable.cmc-table__cell--left.cmc-table__cell--sort-by__symbol')[y].text
    while element !="QKC"
    y +=1
    array_symbol << element = page.css('table td.cmc-table__cell.cmc-table__cell--sortable.cmc-table__cell--left.cmc-table__cell--sort-by__symbol')[y].text
        end


array_value = []
z = 0
array_value << element = page.css('table td.cmc-table__cell.cmc-table__cell--sortable.cmc-table__cell--right.cmc-table__cell--sort-by__price')[z].text
    while z !=199
    z +=1
    array_value << element = page.css('table td.cmc-table__cell.cmc-table__cell--sortable.cmc-table__cell--right.cmc-table__cell--sort-by__price')[z].text
    end

    clean = array_value.map { |word| word.gsub('$', '') }

    result = Hash[array_symbol.zip(clean)]
    print result

#names = 'table td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol"]'
#p names_array = page.css(names).map(&:text)


# symbol.each {|smbol| puts smbl.text}



# a = [
#     { "BTC" => 5245.12 },
#     { "ETH" => 217.34 }, 
#   ]