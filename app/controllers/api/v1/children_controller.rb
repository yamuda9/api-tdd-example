class API::V1::ChildrenController < ApplicationController
  def index
    childrens = Children.all
    render json: childrens.to_json, status: 200
  end

  def show
    @children = Children.find_by(id: params[:id])

    if @children
      render json: { success: true,
                     first_name: @children.first_name,
                     last_name: @children.last_name,
                     age: @children.age,
                     date_of_birth: @children.date_of_birth
      }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end
end
