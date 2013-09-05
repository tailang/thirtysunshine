#encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  load_and_authorize_resource
  def index
  	#@users = User.all
  end
  
  def show
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
end
