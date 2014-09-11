class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :content
      t.timestamps
    end
  end
end
