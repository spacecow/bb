class AddStatsToFamiliars < ActiveRecord::Migration
  def change
    add_column :familiars, :maxhp, :integer
    add_column :familiars, :maxatk, :integer
    add_column :familiars, :maxdef, :integer
    add_column :familiars, :maxwis, :integer
    add_column :familiars, :maxagi, :integer
  end
end
