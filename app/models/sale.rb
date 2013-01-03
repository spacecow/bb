class Sale < ActiveRecord::Base
  belongs_to :familiar

  attr_accessor :familiar_token
  attr_accessible :familiar_token, :value, :unit

  validates :familiar, presence:true
  validates :value, presence:true, exclusion:{in:[0], message:'cannot be zero'}
  validates :unit_mask, presence:true

  UNITS = ['Hearts Blood', 'Mandrake']
  WEIGHT = [2, 1]

  def familiar_token=(token)
    self.familiar_id = Familiar.id_from_token(token)
  end

  def regulated_value
    WEIGHT[unit_mask]*value
  end

  def unit=(s)
    #self.unit_mask = 2**UNITS.index(s)
    self.unit_mask = UNITS.index(s)
  end

  def unit
    UNITS[unit_mask] if unit_mask
  end
end
