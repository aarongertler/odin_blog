class ArticlesController < ApplicationController

  def index
    @articles = Article.all  # An instance variable, since view and controller both need to use it
  end # Anything we want available in the view template should be an instance variable

  def show
    @article = Article.find(params[:id]) # grabs :id from the url
    # params returns a hash of all request parameters, we've chosen "id" from among them
  end

end
