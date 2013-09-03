class RemoveLastActivedMarkFromTopics < ActiveRecord::Migration
  def up
    remove_column :topics, :last_actived_mark
  end

  def down
    add_column :topics, :last_actived_mark, :integer
  end
end
