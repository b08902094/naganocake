class Public::CustomersController < ApplicationController
  def show
  end
  def edit
  end
  def confirm
    @customer = Customer.find_by(email: params[:email])
  end
  def update
    if @customer.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end
end

  def customer_params
    params.require(:customer).permit(:lastname, :firstname, :firstname_kana, :lastname_kana, :email, :postal_code, :address, :phone)
  end