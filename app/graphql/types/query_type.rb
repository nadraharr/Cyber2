# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    
    field :repos, String, null: false do
      argument :userLogin, String, required: true
    end
    def repos(userLogin:)
      token = ENV['GITHUB_TOKEN'] 
      connection = Faraday.new(url: "https://api.github.com/users/#{userLogin}/repos") do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Authorization'] = "Bearer #{token}"
      faraday.adapter Faraday.default_adapter
    end
      response = connection.get
      result = JSON.parse(response.body)
    end

    field :name, String, null: false do
      argument :userLogin, String, required: true
    end
    def name(userLogin:)
      token = ENV['GITHUB_TOKEN']
      connection = Faraday.new(url: "https://api.github.com/users/#{userLogin}") do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Authorization'] = "Bearer #{token}"
      faraday.adapter Faraday.default_adapter
    end
      response = connection.get
      result = JSON.parse(response.body)
    end

  end
end