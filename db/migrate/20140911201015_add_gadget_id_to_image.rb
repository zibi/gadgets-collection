class AddGadgetIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :gadget_id, :integer
    add_index :images, :gadget_id
  end
end
