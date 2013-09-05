#encoding: utf-8
class NodesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  load_and_authorize_resource
  def index
  	#@nodes = Node.all
  end

  def show
    #@node = Node.find(params[:id])
    @topics = @node.topics.paginate(:page => params[:page], :per_page => 15)
  end
  
  def new
  	@node = Node.new
  end

  def create
  	@node = Node.new(params[:node])
  	if @node.save
  	  redirect_to nodes_path
  	else
  	  render :action => new
      flash[:success] = "创建节点失败"
  	end
  end

  
  def destroy
    @node.destroy
    redirect_to nodes_path
  end
end
