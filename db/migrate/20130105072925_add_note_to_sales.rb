class AddNoteToSales < ActiveRecord::Migration
  def change
    add_column :sales, :note, :string
  end
end
