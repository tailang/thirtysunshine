#encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :topics]
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:topics, :follows]
  def index
  	#@users = User.all
  end
  
  def show
    @topics = @user.topics.order('created_at desc').limit(10)
    @comments = @user.comments.order('created_at desc').limit(10)
  	#@user = User.find(params[:id])
  end

  def edit
  	#@user = User.find(params[:id])
  end

  def update
  	#@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
  	  redirect_to @user
  	  flash[:success] = "设置成功"
  	else
  	  render action: "edit"
      flash[:success] = "设置失败"
  	end
  end

  def topics
    @user = User.find(params[:id])
    @topics = @user.topics.paginate(:page => params[:page], :per_page => 1)
  end

  def follows
    @user = User.find(params[:id])
    @follow_topics = @user.follows.paginate(:page => params[:page], :per_page => 1)
  end
end
