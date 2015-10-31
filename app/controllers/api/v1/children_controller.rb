class API::V1::ChildrenController < ApplicationController
  def index
    childrens = Children.all
    render json: childrens.to_json, status: 200
  end
end
