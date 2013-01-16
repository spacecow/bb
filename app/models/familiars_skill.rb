class FamiliarsSkill < ActiveRecord::Base
  belongs_to :familiar
  belongs_to :skill

  validates :familiar_id, uniqueness:{scope: :skill_id}
end
