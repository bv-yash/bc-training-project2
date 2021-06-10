class CommentsController < ApplicationController
        before_action :require_login, only: [:create, :destory]
        before_action :correct_user, only: [:create, :destory]
        
        def create
                @user = User.find(params[:user_id])
                @article = Article.find(params[:article_id])
                @comment = @article.comments.create(commenter: current_user.name, body: params[:comment][:body], status: params[:comment][:status], article_id: params[:article_id])
                redirect_to user_article_path(@user, @article)
        end

        def destroy
                @user = User.find(params[:user_id])
                @article = Article.find(params[:article_id])
                @comment = @article.comments.find(params[:id])
                @comment.destroy
                redirect_to user_article_path(@user, @article)
        end

        def correct_user
                @user = User.find(params[:user_id])
                if  !current_user.nil? &&  @user.id != current_user.id
                        render :file => "#{Rails.root}/public/422.html",  layout: false, status: 422
                end
        end
end
