#encoding: utf-8
class TopicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  load_and_authorize_resource
  def index
  	#@topics = Topic.paginate(:page => params[:page], :per_page => 15)
    @topics = @topics.paginate(:page => params[:page], :per_page => 15)
    @nodes = Node.all
  end

  def show
  	#@topic = Topic.find(params[:id])
     @comments = @topic.comments.paginate(:page => params[:page], :per_page => 20)
     @node = @topic.node 
  end

  def new
  	@topic = Topic.new
  end
  
  def edit
    #@topic = Topic.find(params[:id])
  end

  def create
  	@topic = Topic.new(params[:topic])
  	@topic.user = current_user
  	if @topic.save
  	  redirect_to @topic
  	else
  	  render :action => "new"
      flash[:success] = "创建话题失败"
  	end
  end

  def update
    #@topic = Topic.find(params[:id])

    if @topic.update_attributes(params[:topic])
      redirect_to @topic
      flash[:success] = "成功修改话题"
    else
      render :action => "edit"
    end
  end

  def destroy
    #@topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_url
    flash[:success] = "成功删除话题"
  end

end
