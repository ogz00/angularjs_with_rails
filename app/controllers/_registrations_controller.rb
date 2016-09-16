class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token, :only => :create
  private

  def sign_up_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :phone, :birth_date, :address, :gender)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :phone, :birth_date, :address, :gender)
  end
end