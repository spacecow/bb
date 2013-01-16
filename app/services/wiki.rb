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

    def skill_paths(name)
      doc = doc(max_evolved_url name)
      urls = [doc.at_xpath("//table[@class='infobox']/tr[10]/td[2]/a").attribute('href').value]
      second_skill = doc.at_xpath("//table[@class='infobox']/tr[10]/td[2]/a[2]")
      urls.push second_skill.attribute('href').value unless second_skill.nil? 
      urls
    end

    def skill_infos(name)
      skill_paths(name).map do |path|
        doc = doc(url path)
        info = [skill_name(doc)]
        info.push skill_description(doc)
        info.push skill_note(doc)
        info
      end
    end

    def skill_name(doc)
      doc.at_xpath("//header[@id='WikiaPageHeader']/h1").text
    end
    def skill_description(doc)
      desc = doc.at_xpath("//table[@class='infobox']/tr[2]/td[2]/div")
      desc = doc.at_xpath("//div[@id='mw-content-text']/p") if desc.nil?
      desc.text.strip
    end
    def skill_note(doc)
      note = doc.at_xpath("//table[@class='infobox']/tr[5]/td[2]")
      note = doc.at_xpath("//div[@id='mw-content-text']/p[2]") if note.nil?
      note.text.gsub("\n"," ").strip
    end

    def url(path)
      path.gsub!(/\/wiki\//,'')
      "http://bloodbrothersgame.wikia.com/wiki/#{path.gsub(/ /,'_')}"
    end

    def doc(url)
      doc = Nokogiri::HTML(open url)
    end
  end
end
