class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_item, only: [:show, :edit, :update, :destroy,:upvote]
  before_action :admin? ,    only: [:edit]
  def index
    @items = Item.all
    @items = @items.includes(:image)
    # @items=@items.where('price >=?', params[:price_from]) if params[:price_from]
    #   @items=@items.where('created_at >=?', 1.day.ago) if params[:today]
    #   @items=@items.where('votes_count >=?', params[:votes_from]) if params[:votes_from]
    # @items=@items.order(:id)

  end

  def create
    @item=Item.create(items_params)
    if @item.persisted?
      flash[:success] = 'Item added to db'
      redirect_to items_path
    else
      flash.now[:error] = "Enter all field please"
      render :new
    end
  end
  def new
    #flash[:error] = "Enter all field please"
    @item = Item.new
  end

  # def edit
  #   render body: 'Page not found' ,status: 404 unless  @item
  # end

  def update
    #binding.pry
    if @item.update(items_params)
      flash[:success] = 'Item was update'
      redirect_to item_path
    else
      flash[:error] = "Enter all field please"
      render :edit
    end

  end

   #def show
  #     render body: 'Page not found' ,status: 404 unless  @item
   #end
  def destroy
    if @item.destroy.destroyed?#(items_params)
      flash[:success] = 'Item was deleted'
      redirect_to items_path
    else
      flash.now[:error] = "Cant destroy"
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
    params.require(:item).permit(:name,:price,:real,:weight,:description)
  end
  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end


end
