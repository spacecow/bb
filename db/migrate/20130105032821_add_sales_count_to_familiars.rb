class AddSalesCountToFamiliars < ActiveRecord::Migration
  def change
    add_column :familiars, :sales_count, :integer, :default => 0
  end
end
