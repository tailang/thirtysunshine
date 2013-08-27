class Topic < ActiveRecord::Base
  attr_accessible :title, :body, :node_id

  belongs_to :user
  belongs_to :node
  
  default_scope :order => 'id DESC'
  
  validates :title, :presence => true
  validates :body, :presence => true
  validates :user_id, :presence => true
  validates :node_id, :presence => true
end
