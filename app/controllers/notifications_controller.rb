class NotificationsController < ApplicationController
  before_filter :authenticate_user!, :only => :index
  after_filter :mark_read, :only => :index
  def index
  	@notifications = current_user.notifications
  end

  private

  def mark_read
  	current_user.notifications.update_all(:unread => false)
  end
end
