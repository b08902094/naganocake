class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
  end

  def search
    @range = params[:range]
    if @range == "Customer"
      @customers = Customer.looks(params[:search], params[:keyword])
    else
      @items = Item.looks(params[:search], params[:keyword])
    end
  end
end
