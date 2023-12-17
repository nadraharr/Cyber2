# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  def index; end
  
  def execute
    user_login = params[:user_login].to_s.strip
    if user_login.match?(/\A[A-Za-z0-9_-]+\z/)
    variables = prepare_variables(params[:variables])
    query = "query { repos(userLogin: \"#{user_login}\") }"
    operation_name = params[:operationName]
    context = {}
    result = CyberTestSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    result = result.to_h
   
    if !execute_name["errors"]
      @name = eval(execute_name["data"]["name"])
    else     
      @name = ""      
    end
    

    if !result["errors"]
      @result = eval(result["data"]["repos"])      
    else 
      @result = ""
    end
    
  else
    @name = ""
    @result = ""
  end
  end
 

  private

  def execute_name
    variables = prepare_variables(params[:variables])
    query = "query { name(userLogin: \"#{params[:user_login]}\") }"
    operation_name = params[:operationName]
    context = {}
    result = CyberTestSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    result = result.to_h
  end
  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
         JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end


end
