class ArticlesController < ApplicationController
  include ArticlesHelper

  def new
    @article = Article.new
  end

  def create
    @article = current_user.authored_articles.build(article_params)
    @article.categories.build(name: params[:article][:categories][:name])
    if @article.save
      redirect_to article_path(@article), notice: 'Article created succesfully'
    else
      redirect_to new_article_path, alert: 'This article can\'t be create'
    end
  end

  private 

  def article_params
    params.require(:article).permit(:title, :content, :image)
  end
end
