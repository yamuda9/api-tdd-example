require 'rails_helper'

RSpec.describe API::V1::ChildrenController, type: :controller do
  context "GET #index" do
    it "returns http status of 200" do
      children = Children.create!(first_name: "Joe", last_name: "Smith", age: 18, date_of_birth: DateTime.new(1997))

      get :index
      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')

      response_message = JSON.parse(response.body)
      expect(response_message.length).to eq(1)
    end
  end

  context "GET children/id" do
    it "valid id" do
      children = Children.create!(first_name: "Joe", last_name: "Smith", age: 18, date_of_birth: DateTime.new(1997))

      get :show, id: children
      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')

      response_message = JSON.parse(response.body)
      expect(response_message["success"]).to eq(true)
      expect(children.first_name).to eq(response_message["first_name"])
      expect(children.last_name).to eq(response_message["last_name"])
      expect(children.age).to eq(response_message["age"])
      expect(children.date_of_birth).to eq(response_message["date_of_birth"])
    end

    it "invalid id" do
      children = Children.create!(first_name: "Joe", last_name: "Smith", age: 18, date_of_birth: DateTime.new(1997))

      get :show, id: 99
      expect(response.status).to eq(422)
      expect(response.content_type).to eq('application/json')

      response_message = JSON.parse(response.body)
      expect(response_message["success"]).to eq(false)
    end
  end
end
