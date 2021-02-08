class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @items=Item.all

  end

  def create
    item=Item.create(items_params)
    if item.persisted?
      render json: item.name, status: :created
    else
      render json: item.errors,  status: :unprocessable_entity
    end

  end
  def new

  end

  def edit
    #@item=Item.where(id: params[:id])
  end

  def update

  end

  def show
  unless  @item=Item.where(id: params[:id]).first
      render body: 'Page not found' ,status: 404
    end
  end

  def destroy
    Item.where(id: params[:id]).first.destroy
  end

  private
  def items_params
    params.permit(:name,:price,:real,:weight,:description)
  end
end
