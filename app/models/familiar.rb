require 'nokogiri'

class Familiar < ActiveRecord::Base
  has_many :sales, dependent: :destroy

  attr_accessible :name, :remote_image_url
  mount_uploader :image, ImageUploader

  validates :name, presence:true, uniqueness:true

  def done_sales
    arr = sales
    arr.pop if arr.last and arr.last.new_record?
    arr 
  end

  def median
    sorted = regulated_sale_values.sort    
    sorted[sorted.count/2]
  end

  def regulated_sale_values
    sales.map(&:regulated_value)
  end
  def regulated_sale_values_freq(delete_last=true)
    arr = regulated_sale_values
    arr.pop if delete_last
    arr.frequency
  end

  def static_image_url
    p "!!!!!!!!!!!!!!!!!!!!!!!!!!"
    url = "http://bloodbrothersgame.wikia.com/wiki/#{self.name}"
    doc = Nokogiri::HTML(open(url))
    image_url = doc.at_css("table.infobox img").attribute('src').value
  end

  class << self
    def id_from_token(token)
      if token =~ /<<<(.+?)>>>/
        familiar = new(name:$1)
        unless Rails.env.test?
          url = "http://bloodbrothersgame.wikia.com/wiki/#{$1}"
          doc = Nokogiri::HTML(open(url))
          image_url = doc.at_css("table.infobox img").attribute('src').value
          familiar.remote_image_url = image_url
        end
        familiar.save
        token.gsub!(/<<<(.+?)>>>/){ familiar.id } 
      end
      token
    end

    def tokens(query)
      where("name like ?", "%#{query}%") + [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    end
  end
end
