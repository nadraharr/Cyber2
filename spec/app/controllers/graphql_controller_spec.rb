# frozen_string_literal: true
    RSpec.describe GraphqlController, type: :controller do
    subject(:graphql_controller) { described_class.new }
  
    before do
      allow(graphql_controller).to receive(:params).and_return({ user_login: 'dhh' })
    end
    
    it "returns empty strings" do
      graphql_controller.execute("{}")
      expect(graphql_controller.instance_variable_get(:@result)).to eq('')      
      expect(graphql_controller.instance_variable_get(:@name)).to eq('')  
    end
  
    it "returns empty strings" do
      graphql_controller.execute("")
      expect(graphql_controller.instance_variable_get(:@result)).to eq('')      
      expect(graphql_controller.instance_variable_get(:@name)).to eq('')  
    end
  
    it "returns hash/array" do
      graphql_controller.execute
      expect(graphql_controller.instance_variable_get(:@result)).to be_an_instance_of(Array)      
      expect(graphql_controller.instance_variable_get(:@name)).to be_an_instance_of(Hash)   
    end
    
  end
  