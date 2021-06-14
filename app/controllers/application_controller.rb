class ApplicationController < ActionController::Base
        helper_method :current_user
        helper_method :logged_in?

        protect_from_forgery with: :exception
        
        def current_user
                User.find_by(id: session[:user_id])
        end

        def logged_in?
                !current_user.nil?
        end

        private

        def require_login
                unless logged_in?
                   flash[:error] = "You must be logged in to access this section"
                   redirect_to login_path
                end
        end

        def correct_user
                @user = params[:controller] == 'users' ? User.find_by(id: params[:id]) : User.find_by(id: params[:user_id]) 
                if  !current_user.nil? &&  @user.id != current_user.id
                        render :file => "#{Rails.root}/public/422.html",  layout: false, status: 422
                end
        end
end
