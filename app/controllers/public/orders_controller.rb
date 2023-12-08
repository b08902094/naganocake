class Public::OrdersController < ApplicationController
  def new
    check_empty
    @order = Order.new
  end

  def confirm
    @total = 0
    @cart_items = CartItem.all
    @order = Order.new
    if params[:order][:address_option] == "0"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.firstname + current_customer.lastname
    elsif params[:order][:address_option] == "1"
      @order = Order.new(order_params)
      @address = current_customer.addresses.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_option] == "2"
      @order = Order.new(order_params)
      @order.save
    end
    @order.shipping_fee = 800
  end

  def done
  end

  def create
    order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    if order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item.id
        @order_detail.order_id = order.id
        @order_detail.quantity = cart_item.quantity
        @order_detail.price = cart_item.item.price_before_tax
        @order_detail.save
      end
      redirect_to order_done_path
      @cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def index
  end

  def show
  end


  private
  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :quantity, :shipping_fee, :total)
  end
  def check_empty
    @cart_items = CartItem.all
    unless @cart_items.exists?
      flash[:notice] = 'カートが空です'
      redirect_to cart_items_path
    end
  end
end
