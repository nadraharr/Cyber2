# frozen_string_literal: true

Rails.application.routes.draw do
  root 'graphql#index'

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
end
