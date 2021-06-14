class CommentsController < ApplicationController
        before_action :require_login, only: [:create, :destory]
        before_action :correct_user, only: [:destory]
        
        def create
                @user = User.find_by(id: params[:user_id])
                @article = Article.find_by(id: params[:article_id])
                if @article.private? &&  (!current_user.nil? && current_user.id != @user.id)
                        render :file => "#{Rails.root}/public/422.html",  layout: false, status: 422
                else
                        @comment = @article.comments.create(commenter: current_user.name, body: params[:comment][:body], status: params[:comment][:status], article_id: params[:article_id], user_id: params[:user_id])
                        redirect_to user_article_path(@user, @article)
                end
        end

        def destroy
                @user = User.find_by(id: params[:user_id])
                @article = Article.find_by(id: params[:article_id])
                @comment = @article.comments.find_by(id: params[:id])
                @comment.destroy
                redirect_to user_article_path(@user, @article)
        end
end
