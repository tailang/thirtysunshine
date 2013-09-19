class FollowsController < ApplicationController
  before_filter :authenticate_user!
  def create
  	@topic = Topic.find(params[:topic_id])
  	current_user.follow(@topic)
    respond_to do |format|
  	  format.html{redirect_to topic_path(@topic)}
      format.js
    end
  end

  def destroy
  	@topic = Topic.find(params[:topic_id])
  	current_user.stop_following(@topic)
    respond_to do |format|
  	  format.html{redirect_to topic_path(@topic)}
      format.js
    end
  end
end
