class AddColumnLastActivedMarkToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :last_actived_mark, :integer
  end
end
