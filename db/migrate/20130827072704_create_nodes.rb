class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.text :introduction
      t.integer :topics_count

      t.timestamps
    end
  end
end
