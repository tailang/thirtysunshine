class FollowsController < ApplicationController
  before_filter :authenticate_user!
  def create
  	topic = Topic.find(params[:topic_id])
  	current_user.follow(topic)
  	redirect_to topic_path(topic)
  end

  def destroy
  	topic = Topic.find(params[:topic_id])
  	current_user.stop_following(topic)
  	redirect_to topic_path(topic)
  end
end
