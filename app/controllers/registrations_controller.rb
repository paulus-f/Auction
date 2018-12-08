class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :second_name, :email, :password,:avatar, :password_confirmation, :about_users) 
  end

  def account_update_params
    params.require(:user).permit(:first_name, :second_name, :email, :password, :password_confirmation, :current_password, :about_users, :avatar)
  end

end