class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.where(order_id: params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params) && @order.payment_confirmed?
      @order.order_details.each do |order_detail|
        order_detail.update!(status: 1)
      end
    end
    redirect_to  admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end


end
