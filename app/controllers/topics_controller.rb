#encoding: utf-8
class TopicsController < ApplicationController

  def index
  	@topics = Topic.all
    @nodes = Node.all
  end

  def show
  	@topic = Topic.find(params[:id])
  end

  def new
  	@topic = Topic.new
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end

  def create
  	@topic = Topic.new(params[:topic])
  	@topic.user = current_user
  	if @topic.save
  	  redirect_to @topic
  	  flash[:success] = "成功创建话题"
  	else
  	  render :action => "new"
  	end
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update_attributes(params[:topic])
      redirect_to @topic
      flash[:success] = "成功修改话题"
    else
      render :action => "edit"
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
  end

end
