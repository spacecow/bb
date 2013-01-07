class AddImageToFamiliars < ActiveRecord::Migration
  def change
    add_column :familiars, :image, :string
  end
end
