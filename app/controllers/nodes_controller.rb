#encoding: utf-8
class NodesController < ApplicationController
  def index
  	@nodes = Node.all
  end

  def show
    @node = Node.find(params[:id])
    @topics = @node.topics
  end
  
  def new
  	@node = Node.new
  end

  def create
  	@node = Node.new(params[:node])
  	if @node.save
  	  redirect_to nodes_path
  	  flash[:success] = "成功创建节点"
  	else
  	  render :action => new
  	end
  end
end
