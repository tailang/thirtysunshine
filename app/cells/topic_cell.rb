class TopicCell < Cell::Rails
  
  cache :site_infos, :expires_in => 1.hours
  cache :site_about, :expires_in => 30.days

  def site_infos
   @users_count = User.unscoped.count
   @topics_count = Topic.unscoped.count
   @comments_count = Comment.unscoped.count
   render
  end

  def site_about
    render
  end

  def node_other_topics(args)
    @node = args[:node]
    @topics = @node.topics.order('created_at desc').limit(7)      
    render    
  end
end
