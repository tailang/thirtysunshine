class Topic < ActiveRecord::Base
  attr_accessible :title, :body, :node_id
  acts_as_commentable

  belongs_to :user
  belongs_to :node

  default_scope :order => 'updated_at DESC'
  
  validates :title, :presence => true
  validates :body, :presence => true
  validates :user_id, :presence => true
  validates :node_id, :presence => true
end
