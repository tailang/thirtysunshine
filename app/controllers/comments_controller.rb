#encoding: utf-8
class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :edit, :destroy, :update]
  load_and_authorize_resource :comment
  def create
  	@comment = commentable_record.comments.create(params[:comment])
  	@comment.user = current_user 
    respond_to do |format|
      if @comment.save
        format.html{ redirect_to commentable_record }
        format.js
      else
        format.html{ redirect_to commentable_record}
        format.js
      end
    end
  end

  # def edit
  #   #@comment = commentable_record.comments.find(params[:id]) 
  # end


  def destroy
    #@comment = commentable_record.comments.find(params[:id])    
    @comment.destroy
    respond_to do |format|
      format.html{redirect_to commentable_record}
      format.js
    end
  end
  
  def update
    #@comment = commentable_record.comments.find(params[:id])  
    if @comment.update_attributes(params[:comment])
      redirect_to commentable_record
      #flash[:success] = "成功修改评论"
    else
      render :action => "edit"
      flash[:success] = "修改评论失败"
    end
  end

  protected

  def commentable_record
  	Topic.find(params[:topic_id])
  end
  
end
