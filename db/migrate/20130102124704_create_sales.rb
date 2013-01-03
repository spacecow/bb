class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :familiar_id
      t.float :value
      t.integer :unit_mask

      t.timestamps
    end
  end
end
