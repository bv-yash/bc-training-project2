class ArticlesController < ApplicationController
        before_action :require_login, only: [:edit, :update, :new, :create, :destory]
        before_action :correct_user, only: [:edit, :update, :new, :create, :destory]
        
        def show
                @user = User.find_by(id: params[:user_id])
                @article = Article.find_by(id: params[:id])
                if @article.private? && (!current_user.nil? && current_user.id != @user.id)
                        render :file => "#{Rails.root}/public/404.html",  layout: false, status: 404
                end
        end

        def new
                @user = User.find_by(id: params[:user_id])
                @article = @user.articles.build
        end

        def create
                @user = User.find_by(id: params[:user_id])
                @article = @user.articles.create(article_parms)
                if @article.save
                        redirect_to user_article_path(@user, @article)
                else
                        render 'new'
                end
        end

        def edit
                @user = User.find_by(id: params[:user_id])
                @article = Article.find_by(id: params[:id])
        end

        def update
                @user = User.find_by(id: params[:user_id])
                @article = Article.find_by(id: params[:id])
                if @article.update(article_parms)    
                        redirect_to user_article_path(@user, @article)
                else
                        render :edit
                end
        end

        def destroy
                @user = User.find_by(id: params[:user_id])
                @article = Article.find_by(id: params[:id])
                @article.destroy
                
                redirect_to user_path(@user)
        end

        private
        def article_parms
                params.require(:article).permit(:title, :body, :status, :user_id)
        end 
end
