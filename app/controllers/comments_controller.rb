class CommentsController < ApplicationController
        before_action :require_login, only: [:create, :destory]
        
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
end
