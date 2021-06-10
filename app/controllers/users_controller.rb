class UsersController < ApplicationController
        before_action :require_login, only: [:edit, :update, :destory]
        before_action :correct_user, only: [:edit, :update, :destory]

        def index
                redirect_to root_path
        end

        def show
                @user = User.find_by(id: params[:id])
        end
        
        def new
                @user = User.new
        end

        def create
                @user = User.new(user_params)
                if @user and @user.save
                        session[:user_id] = @user.id
                        redirect_to root_path
                else
                        render 'new'
                end
        end

        def edit
                @user = User.find_by(id: params[:id])
        end

        def update
                @user = User.find_by(id: params[:id])
                if @user and @user.update(user_params)    
                        redirect_to @user
                else
                        render :edit
                end
        end

        def destroy
                @user = User.find_by(id: params[:id])
                @user.destroy unless @user.nil?

                redirect_to root_path
        end

        private
        def user_params
                params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end
