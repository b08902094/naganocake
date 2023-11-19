class Admin::CustomersController < ApplicationController
  def customer_params
    params.require(:customer).permit(:lastname, :firstname, :firstname_kana, :lastname_kana, :email, :postal_code, :address, :phone)
  end
end
