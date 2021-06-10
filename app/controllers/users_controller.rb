class UsersController < ApplicationController
        before_action :require_login, only: [:edit, :update, :destory]
        before_action :correct_user, only: [:edit, :update, :destory]

        def index
                redirect_to root_path
        end

        def show
                @user = User.find(params[:id])
        end
        
        def new
                @user = User.new
        end

        def create
                @user = User.new(user_params)
                if @user.save
                        session[:user_id] = @user.id
                        redirect_to root_path
                else
                        render 'new'
                end
        end

        def edit
                @user = User.find(params[:id])
        end

        def update
                @user = User.find(params[:id])
                if @user.update(user_params)    
                        redirect_to @user
                else
                        render :edit
                end
        end

        def destroy
                @user = User.find(params[:id])
                @user.destroy

                redirect_to root_path
        end

        private
        def user_params
                params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end
