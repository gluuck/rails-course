class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_item, only: [:show, :edit, :update, :destroy,:upvote]
  before_action :admin? ,    only: [:edit]
  def index
    @items = Item
    @items=@items.where('price >=?', params[:price_from]) if params[:price_from]
      @items=@items.where('created_at >=?', 1.day.ago) if params[:today]
      @items=@items.where('votes_count >=?', params[:votes_from]) if params[:votes_from]
    @items=@items.order(:id)

  end

  def create
    item=Item.create(items_params)
    if item.persisted?
      redirect_to items_path
    else
      render json: item.errors,  status: :unprocessable_entity
    end
  end
  # def new
  # end

  # def edit
  #   render body: 'Page not found' ,status: 404 unless  @item
  # end

  def update
    #binding.pry
    if @item.update(items_params)
      redirect_to item_path
    else
      render json: item.errors,  status: :unprocessable_entity
    end

  end

  # def show
  #     render body: 'Page not found' ,status: 404 unless  @item
  # end
  def destroy
    if @item.destroy.destroyed?#(items_params)
      redirect_to items_path
    else
      render json: item.errors,  status: :unprocessable_entity
    end
  end
  def upvote
    @item.increment!(:votes_count)
    redirect_to items_path
  end
  def expensive
    @items = Item.where('price >150')
    render :index
  end

  private
  def items_params
    params.permit(:name,:price,:real,:weight,:description)
  end
  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end


end
