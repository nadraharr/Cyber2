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
      connection = Faraday.new(url: "https://api.github.com/users/#{userLogin}/repos")
      response = connection.get
      JSON.parse(response.body)
    end

    field :name, String, null: false do
      argument :userLogin, String, required: true
    end
    def name(userLogin:)
      connection = Faraday.new(url: "https://api.github.com/users/#{userLogin}")
      response = connection.get
      JSON.parse(response.body)
    end

    #field :repo, RepoType
    #def repo
    #  eval(repos(userLogin:)["data"]["repos"]).first
    #end

    #field :reponame, String, null: false
    #def reponame
    #  repo["name"]
    #end

    #field :htmlurl, String, null: false
    #def htmlurl
    #  repo["html_url"]
    #end

  end
end
