class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.includes(:item)
    @total = 0
  end

  def update
    @item = Item.find(params[:item_id])
    @cart_item = current_customer.cart_items.find_by(item_id: @item.id)
    @cart_item.update(update_item_params)
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: cart_item_params[:item_id])
    if cart_item
      tmp = @cart_item.quantity + cart_item.quantity
      cart_item.update(quantity: tmp)
      @cart_item.delete
      redirect_to cart_items_path
    else
      @cart_item.customer_id = current_customer.id
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end

  def update_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
