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
  	  flash[:danger] = "创建评论失败"
  	end
  end

  protected

  def commentable_record
  	Topic.find(params[:topic_id])
  end
  
end
