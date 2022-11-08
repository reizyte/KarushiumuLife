class Public::CustomersController < ApplicationController
  before_action :ensure_correct_customer, only: [:update, :edit]

  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
  end

  #ブックマーク一覧
  def favorites

  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
