class AddDataToSkills < ActiveRecord::Migration
  def up
    add_column :skills, :kind, :string
    add_column :skills, :modifier, :float, :default => 0
    add_column :skills, :status, :string
    add_column :skills, :target, :string
    remove_column :skills, :note
  end

  def down
    remove_column :skills, :kind
    remove_column :skills, :modifier
    remove_column :skills, :status
    remove_column :skills, :target
    add_column :skills, :note, :string
  end
end
