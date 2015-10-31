require 'rails_helper'

RSpec.describe API::V1::ChildrenController, type: :controller do
  context "GET #index" do
    it "returns http status of 200" do
      children = Children.create!(first_name: "Joe", last_name: "Smith", age: "18", date_of_birth: DateTime.new(1997))

      get :index
    end
  end
end
