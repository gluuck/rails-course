class ItemsController < ApplicationController
  def index
    @items=Item.all
      render body: @items.map { |e|  "#{e.name}: #{e.price} : #{e.description} " }
  end
end
