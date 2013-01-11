require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Wiki
  class << self 
    def max_evolved_url(name)
      doc = doc(url name)
      maxrow = doc.at_xpath("//div[@id='mw-content-text']/ul[2]/li[4]/a")
      maxrow = doc.at_xpath("//div[@id='mw-content-text']/ul[2]/li[2]/a") if maxrow.nil?
      return url name if maxrow.nil?
      Wiki.url(maxrow.attribute('href').value)
    end

    #def max_evolved_url_doc(name)
    #  url_doc(max_evolved_url(name)

    def max_stats(name)
      doc = doc(max_evolved_url name)
      evos = doc.at_xpath("//table[@class='article-table']/tr[4]").children.map{|e| e.text.strip.to_i}
      evos[1..-1]
    end

    def url(name)
      name.gsub!(/\/wiki\//,'')
      "http://bloodbrothersgame.wikia.com/wiki/#{name.gsub(/ /,'_')}"
    end

    def doc(url)
      doc = Nokogiri::HTML(open url)
    end
  end
end
