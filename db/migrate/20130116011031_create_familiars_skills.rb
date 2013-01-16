class CreateFamiliarsSkills < ActiveRecord::Migration
  def change
    create_table :familiars_skills do |t|
      t.integer :familiar_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
