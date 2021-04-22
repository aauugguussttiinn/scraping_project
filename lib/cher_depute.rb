require 'rubygems'
require 'nokogiri' 
require 'open-uri'


########### Gets every French mp's profile urls on the French National Assembly's website #################
def get_profiles_urls
    page = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/tableau").read)
    profiles_list = []
    n = 0
    profiles_list << urls = page.css('tbody a')[n]['href']
    while urls != "/deputes/fiche/OMC_PA267330"
        n += 1
        profiles_list << urls = page.css('tbody a')[n]['href']
    end
    clean_urls = profiles_list.map { |word| word.insert(0, 'https://www2.assemblee-nationale.fr') }
    return clean_urls
end

########### Gets a given French mp's first name, last name and email, nests it in a hash #################

def getting_identity(y)
    data_type = ["first_name", "last_name", "email"]    
    page = Nokogiri::HTML(URI.open(y).read)   
    identity = page.css('div.titre-bandeau-bleu.clearfix h1').text.split(" ")
    identity.shift
    if identity.length == 3
        identity[1] = identity[1..2].join(" ")
        identity.delete(identity[2])
    end
    identity << email = page.css('dd ul li[2] a').text
    mp = Hash[data_type.zip(identity)]
    puts mp
end

########### Nests every French mp's professionnal data inside an array #################

final_array = []
get_profiles_urls.each do |y|
final_array << getting_identity(y)
end
puts final_array









#################################### CLEAN CODE #################################### 

# require 'rubygems'
# require 'nokogiri' 
# require 'open-uri'

# def get_profiles_urls
#     page = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/tableau").read)
#     profiles_list = []
#     n = 0
#     profiles_list << urls = page.css('tbody a')[n]['href']
#     while urls != "/deputes/fiche/OMC_PA267330"
#         n += 1
#         profiles_list << urls = page.css('tbody a')[n]['href']
#     end
#     clean_urls = profiles_list.map { |word| word.insert(0, 'https://www2.assemblee-nationale.fr') }
#     return clean_urls
# end

# def getting_identity(y)
#     data_type = ["first_name", "last_name", "email"]    
#     page = Nokogiri::HTML(URI.open(y).read)   
#     identity = page.css('div.titre-bandeau-bleu.clearfix h1').text.split(" ")
#     identity.shift
#     identity << email = page.css('dd ul li[2] a').text
#     mp = Hash[data_type.zip(identity)]
#     puts mp
# end

# get_profiles_urls.each do |y|
#     puts getting_identity(y)
# end