class RegistrationsController < Devise::RegistrationsController
    
    private
    
    ##down here the require is rails safeguaring me so no injection  :)
    ##signing up originally
    def sign_up_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    ##if editing the account this is what is going on
    def account_update_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
    end
end