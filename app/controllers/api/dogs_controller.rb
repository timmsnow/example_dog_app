class Api::DogsController < ApplicationController
  def index
    @dogs = Dog.all
    render "index.json.jb"
  end

  def show
    dog_id = params[:id]
    @dog = Dog.find(dog_id)
    render "show.json.jb"
  end
  
  def create
    @dog = Dog.new(
      name: params[:name],
      age: params[:age],
      breed: params[:breed],
      user_id: current_user.id,
    )
    @dog.save
    #Happy/Sad Path
    if current_user
      render "show.json.jb"
    else
      render json: { errors: "User must be logged in to make doggies" }, status: 400
    end
  end
end
