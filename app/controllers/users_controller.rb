#encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :topics, :follows, :comments]
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:topics, :follows, :comments]
  def index
  	#@users = User.all
    @users = @users.paginate(:page => params[:page], :per_page => 70)
  end
  
  def show
  	#@user = User.find(params[:id])
    set_seo_meta("#{@user.username}","#{@user.username}, #{@user.description}")
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
  end

  def follows
    @user = User.find(params[:id])
  end

  def comments
    @user = User.find(params[:id])
  end
  
end
