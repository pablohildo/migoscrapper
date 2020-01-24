require 'nokogiri'
require 'httparty'
require 'mechanize'

arg_input = ARGV
url = ARGV[0].to_s
document = HTTParty.get(url)
if (!document.body.nil?)
    nokodoc = Nokogiri::HTML(document.body)
else
    puts "Unable to access the given URI"
end

def download_image(url)
    agent = Mechanize.new
    agent.get(url).save
end

imgs = nokodoc.css('.project-module').css('img')

imglist = []

imgs.each do |img|
    if (img.attr("src").include? "blank")
        imglist.push(img.attr("data-src"))
    else
        imglist.push(img.attr("src"))    
    end
end

imglist.each do |img|
    download_image(img)
end


