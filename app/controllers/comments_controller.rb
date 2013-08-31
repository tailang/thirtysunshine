#encoding: utf-8
class CommentsController < ApplicationController
  def create
  	@comment = commentable_record.comments.create(params[:comment])
  	@comment.user = current_user

  	if @comment.save
  	  redirect_to commentable_record
  	  flash[:success] = "成功创建评论"
  	else
  	  redirect_to commentable_record
  	  flash[:error] = "创建评论失败"
  	end
  end

  def edit
    @comment = commentable_record.comments.find(params[:id]) 
  end


  def destroy
    @comment = commentable_record.comments.find(params[:id])    
    @comment.destroy
    redirect_to commentable_record
    flash[:success] = '成功删除评论'
  end
  
  def update
    @comment = commentable_record.comments.find(params[:id])  
    if @comment.update_attributes(params[:comment])
      redirect_to commentable_record
      flash[:success] = "成功修改评论"
    else
      render :action => "edit"
    end
  end

  protected

  def commentable_record
  	Topic.find(params[:topic_id])
  end
  
end
