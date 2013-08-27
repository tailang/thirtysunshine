class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title, :null => false
      t.text :body, :null => false
      t.integer :user_id
      t.integer :node_id
      t.timestamps
    end
  end
end
