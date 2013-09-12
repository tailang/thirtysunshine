class NotificationsController < ApplicationController
  before_filter :authenticate_user!, :only => :index
  after_filter :mark_read, :only => :index
  def index
  	@notifications = current_user.notifications.paginate(:page => params[:page], :per_page => 15)
  end

  def destroy
  	@notification = Notification.find(params[:id])
  	@notification.destroy
    redirect_to notifications_path
  end

  def clear
  	current_user.notifications.delete_all
  	redirect_to notifications_path
  end

  private

  def mark_read
  	current_user.notifications.update_all(:unread => false)
  end
  
end
