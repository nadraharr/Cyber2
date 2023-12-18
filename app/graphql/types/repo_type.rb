module Types
  class RepoType < GraphQL::Schema::Object
    field :reponame, String, null: false
    field :htmlurl, String, null: false
  end    
end