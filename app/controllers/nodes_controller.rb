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
    set_seo_meta("#{@node.name}", "#{@node.introduction}")
  end
  
  def new
  	@node = Node.new
  end

	def edit
		#@node = Node.find(params[:id])
	end

  def create
  	@node = Node.new(params[:node])
  	if @node.save
      redirect_to nodes_path
    else
      render :action => new
      flash[:success] = "创建标签失败"
    end
  end


  def update
    #@node = Node.find(params[:id])

    if @node.update_attributes(params[:node])
      redirect_to @node
      flash[:success] = "修改标签成功"
    else
      render :action => "edit"
    end
  end

  def destroy
    @node.destroy
    redirect_to nodes_path
  end

end
