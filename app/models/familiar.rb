require 'nokogiri'

class Familiar < ActiveRecord::Base
  has_many :familiars_skills, dependent: :destroy
  has_many :skills, through: :familiars_skills

  has_many :sales, dependent: :destroy

  attr_accessible :name, :remote_image_url
  mount_uploader :image, ImageUploader

  validates :name, presence:true, uniqueness:true

  ATTRIBUTES = [['Max damage','max_damage'],['Max HP', 'maxhp'],['Max ATK', 'maxatk'],['Max DEF', 'maxdef'],['Max WIS', 'maxwis'],['Max AGI', 'maxagi']]

  def done_sales
    arr = sales
    arr.pop if arr.last and arr.last.new_record?
    arr 
  end

  def last_sale_created_at
    last_sale = sales.last
    last_sale ? last_sale.created_at : nil 
  end

  def max_damage
    arr = familiars_skills.map(&:max_damage)
    arr.empty? ? 0 : arr.max
  end

  def max_stat(stat)
    return 0 if stat.nil?
    send "max#{stat}"
  end

  def median(len = sales.length)
    Johan::Math.median(regulated_sale_values len) || 0
  end
  
  def regulated_sale_values(len = sales.length)
    sales.order(:created_at).last(len).map(&:regulated_value)
  end
  def regulated_sale_values_freq(delete_last=true)
    arr = regulated_sale_values
    arr.pop if delete_last
    arr.frequency
  end
  
  def static_image_url; Familiar.static_image_url(self.name) end

  class << self
    def id_from_token(token)
      if token =~ /<<<(.+?)>>>/
        familiar = new(name:$1)
        begin
          familiar.remote_image_url = static_image_url($1) unless Rails.env.test?
        rescue OpenURI::HTTPError
        end
        familiar.save
        token.gsub!(/<<<(.+?)>>>/){ familiar.id } 
      end
      token
    end

    def static_image_url(name)
p "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      url = "http://bloodbrothersgame.wikia.com/wiki/#{name.gsub(/ /,'_')}"
      doc = Nokogiri::HTML(open(url))
      image = doc.at_css("table.infobox a.image img").attribute('src')
      return image.value if image.value =~ /^http/
      image = doc.at_css("table.infobox a.image img").attribute('data-src')
      image.value
    end

    def tokens(query)
      where("name like ?", "%#{query}%") + [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    end
  end
end
