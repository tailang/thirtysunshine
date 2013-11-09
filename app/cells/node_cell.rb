class NodeCell < Cell::Rails
  
  cache :node_infos, :expires_in => 30.days

  def node_infos(args)
    @node = args[:node]
    render
  end

end
