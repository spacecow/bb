class FamiliarsSkill < ActiveRecord::Base
  belongs_to :familiar
  belongs_to :skill

  validates :familiar_id, uniqueness:{scope: :skill_id}

  def kind; skill.kind end
  def max_damage
    (skill.target_no * familiar.max_stat(skill.status) * skill.modifier).to_i
  end
end
