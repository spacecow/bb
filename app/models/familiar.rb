class Familiar < ActiveRecord::Base
  has_many :sales

  attr_accessible :name

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

  class << self
    def id_from_token(token)
      token.gsub!(/<<<(.+?)>>>/){ create!(name:$1).id}
      token
    end

    def tokens(query)
      where("name like ?", "%#{query}%") + [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    end
  end
end
