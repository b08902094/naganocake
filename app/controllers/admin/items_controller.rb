class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @items = Item.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_items = @genre.items
    else
      all_items = Item.includes(:genre)
    end
    @all_items_count = all_items.count

  end

  def new
    @item = Item.new
  end

  def create
    @items = Item.all
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Your item has been created successfully"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:notice] = "error: failed to create"
      render :index
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :is_active, :price_before_tax, :item_image, :genre_id)
  end
end
