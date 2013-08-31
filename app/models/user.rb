#encoding: utf-8
class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#,
         #:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username, :gender, :description, :province, :city,
                  :school, :douban, :sinaweibo, :site
  attr_accessible :avatar, :avatar_cache

  has_many :topics
  has_many :comments
  
  validates :username, :presence => true, :uniqueness => true, :length => {:maximum => 12}
  validate :username_cannot_contain_invalid_characters

  private
    def username_cannot_contain_invalid_characters
        if self.username.present? and (self.username.include?('@') or
                                     self.username.include?('-') or
                                     self.username.include?(' ') or
                                     self.username.include?('.') or
                                     self.username.include?('/') or
                                     self.username.include?('\\')
                                    )
        errors.add(:username, "不能包含@, 横线, 斜线, 句点或空格")
      end
    end
end
