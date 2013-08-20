class AddProfileToUsers < ActiveRecord::Migration
  def change
  	change_table(:users) do |t|
  	  t.string :username
  	  t.boolean :gender
  	  t.text :description
  	  t.string :province, :limit => 6
  	  t.string :city, :limit => 6
  	  t.string :school
  	  t.string :douban 
  	  t.string :sinaweibo
  	  t.string :site
  	end
  end
end
