class NodeCell < Cell::Rails
  

  def node_infos(args)
    @node = args[:node]
    render
  end

end
