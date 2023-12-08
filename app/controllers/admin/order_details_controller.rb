class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:id])
    @order_details = @order.order_details
    if @order_detail.update(order_detail_params) && @order_detail.production_in_progress?
      @order.update!(status: 2)
    elsif @order_details.count == @order_details.done.count
      @order.update!(status: 3)
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:status)
  end
end
