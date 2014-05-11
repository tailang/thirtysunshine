module Thirtysunshine
  class API < Grape::API
    format :json
    content_type :json, 'application/json'
    prefix "api"
    resource :topics  do
      desc 'topics list'
      get do
        topics = Topic.all
        Jbuilder.encode do |json|
          json.result topics do |topic|
            json.(topic, :id, :title, :body, :user_id, :node_id, :created_at, :updated_at)
          end
        end
      end
    end
  end
end