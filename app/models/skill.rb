class Skill < ActiveRecord::Base
  has_many :familiars_skills, dependent: :destroy
  has_many :familiars, through: :familiars_skills

  attr_accessible :description, :name

  def target_no
    s = target
    return 0 if s.nil?
    s = s.split[0] 
    s = "5" if s == 'All'
    s.to_i
  end
end
