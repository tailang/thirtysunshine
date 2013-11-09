class UserCell < Cell::Rails
  helper ApplicationHelper

  cache :douban, :expires_in => 1.days
  cache :current_topics, :expires_in => 1.hours
  cache :current_comments, :expires_in => 1.hours
  cache :follow_topics, :expires_in => 1.hours
  cache :all_topics, :expires_in => 1.hours
  cache :all_comments, :expires_in => 1.hours
  cache :all_follow_topics, :expires_in => 1.hours
  cache :current_user_infos, :expires_in => 1.hours  
  cache :welcome, :expires_in => 30.days  
  def douban(args)
    @user = args[:user]
    render
  end
  
  def current_comments(args)
    @user = args[:user] 
    @comments = @user.comments.order('created_at desc').limit(5)
    render 
  end

  def current_topics(args)
    @user = args[:user]
    @topics = @user.topics.order('created_at desc').limit(5)
    render
  end

  def follow_topics(args)
    @user = args[:user]
    @follows_topic = @user.follows.order('created_at desc').limit(5)
    render
  end

  def all_topics(args)
    @user = args[:user]
    @topics = @user.topics.paginate(:page => params[:page], :per_page => 20)
    render
  end

  def all_comments(args)
    @user = args[:user]
    @comments = @user.comments.paginate(:page => params[:page], :per_page => 20)
    render
  end

  def all_follow_topics(args)
    @user = args[:user]
    @follows_topic = @user.follows.paginate(:page => params[:page], :per_page => 20)
    render
  end

  def current_user_infos(args)
    @user = args[:user] 
    render
  end

  def welcome
    render
  end
end
