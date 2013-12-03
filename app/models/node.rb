class Node < ActiveRecord::Base
  attr_accessible :introduction, :name, :topics_count
  has_many :topics, :dependent => :destroy
end
