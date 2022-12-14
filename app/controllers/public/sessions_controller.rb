# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

   protected
    # 退会しているかを判断するメソッド
    def customer_state
     @customer = Customer.find_by(email: params[:customer][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
     return if !@customer
    # もし取得したアカウントのパスワードと入力されたパスワードが一致している、且つ退会済み場合
     if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
      redirect_to new_customer_registration_path, notice: "退会済みです。別のメールアドレスをご使用ください。"
     end
    end

end
