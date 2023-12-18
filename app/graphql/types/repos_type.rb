module Types
  class ReposType < GraphQL::Schema::Object
    field :repo, [RepoType]
  end
end