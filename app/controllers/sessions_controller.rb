class SessionsController < ApplicationController
        
        def new
        end

        def login
                @user = User.find_by(email: params[:email])     
                if @user && @user.authenticate(params[:password])
                        session[:user_id] = @user.id
                        redirect_to @user
                else
                        flash.now[:alert] = "User ID and/or Password Invalid!"
                        render 'new'
                end
        end

        def logout
                session[:user_id] = nil
                redirect_to root_path
        end
end