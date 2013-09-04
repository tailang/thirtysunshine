class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  #default_scope :order => 'created_at DESC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  has_many :notifications
  belongs_to :commentable, :polymorphic => true, :touch => true
  belongs_to :user

  validates :user, :presence => true
  validates :comment, :presence => true

  attr_accessible :comment, :title

  after_create :sent_notifications

  private

  def here_users
    all = []
    all = self.comment.scan(/@([a-zA-Z0-9_\-\p{han}]+)/u).collect {|matched| matched.first}
    unless all.include?(self.commentable.user.username)
      all << self.commentable.user.username
    end
    all.uniq
    all.map {|name| User.find_by_username(name)}.compact
  end

  def sent_notifications
    here_users.each do |u|
      Notification.create(:user_id => u.id, :comment_id => self.id) unless u.id == self.user_id
    end
  end

end
