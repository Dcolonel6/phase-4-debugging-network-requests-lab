class ToysController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :render_resource_not_found

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toys.create(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = find_toy
    toy.update(toy_params)
    render json: toy, status: :accepted
  end

  def destroy
    toy = find_toy
    toy.destroy
    head :no_content
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end
  
  def render_resource_not_found
    render json: {error: "Toy not Found" }, status: :not_found    
  end

  def find_toy
    Toy.find(params[:id])
  end

end
