class Skill < ActiveRecord::Base
  has_many :familiars_skills, dependent: :destroy
  has_many :familiars, through: :familiars_skills

  attr_accessible :description, :name
end
