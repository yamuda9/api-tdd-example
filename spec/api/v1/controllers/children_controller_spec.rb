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

  context "POST children" do
    it "valid attributes" do
      children = Children.create!(first_name: "Joe", last_name: "Smith", age: 18, date_of_birth: DateTime.new(1997))
      expect{ post :create, children: { first_name: "Joe", last_name: "Smith", age: 18, date_of_birth: DateTime.new(1997) } }.to change{Children.count}.by(1)

      expect(response.status).to eq(201)
      expect(response.content_type).to eq('application/json')

      response_message = JSON.parse(response.body)
      expect(response_message["success"]).to eq(true)
      expect(children.first_name).to eq(response_message["first_name"])
      expect(children.last_name).to eq(response_message["last_name"])
      expect(children.age).to eq(response_message["age"])
      expect(children.date_of_birth).to eq(response_message["date_of_birth"])
    end

    it "invalid attributes" do
      expect{ post :create, children: { first_name: nil, last_name: "Smith", age: 18, date_of_birth: DateTime.new(1997) } }.to change{Children.count}.by(0)

      expect(response.status).to eq(422)
      expect(response.content_type).to eq('application/json')

      response_message = JSON.parse(response.body)
      expect(response_message["success"]).to eq(false)
    end
  end

  context "PATCH post/id" do
    it "valid attributes" do
      children = Children.create!(first_name: "Joe", last_name: "Smith", age: 18, date_of_birth: DateTime.new(1997))
      updated_children = Children.create!(first_name: "Jack", last_name: "Jill", age: 19, date_of_birth: DateTime.new(1996))

      patch :update, id: children, children: { first_name: "Jack", last_name: "Jill", age: 19, date_of_birth: DateTime.new(1996) }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')

      response_message = JSON.parse(response.body)
      expect(response_message["success"]).to eq(true)
      expect(updated_children.first_name).to eq(response_message["first_name"])
      expect(updated_children.last_name).to eq(response_message["last_name"])
      expect(updated_children.age).to eq(response_message["age"])
      expect(updated_children.date_of_birth).to eq(response_message["date_of_birth"])
    end

    it "valid attributes" do
      children = Children.create!(first_name: "Joe", last_name: "Smith", age: 18, date_of_birth: DateTime.new(1997))

      patch :update, id: children, children: { first_name: nil, last_name: "Jill", age: 19, date_of_birth: DateTime.new(1996) }

      expect(response.status).to eq(422)
      expect(response.content_type).to eq('application/json')

      response_message = JSON.parse(response.body)
      expect(response_message["success"]).to eq(false)
    end
  end
end
