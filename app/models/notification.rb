class Notification < ActiveRecord::Base
  attr_accessible :comment_id, :user_id, :unread
  belongs_to :user
  belongs_to :comment
  
  validates :comment_id, :presence => true
  validates :user_id, :presence => true
  
  default_scope :order => 'created_at DESC'
end
