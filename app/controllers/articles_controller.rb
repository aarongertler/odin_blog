class ArticlesController < ApplicationController
  include ArticlesHelper

  before_filter :require_login, except: [:show, :index]
  # before_filter :require_author, except: [:new, :create]  # This will only work once we add authors to the articles

  # def require_author
  #   unless @article.author.email == current_user.email
  #     redirect_to root_path
  #     return false
  #   end
  # end

  def index
    @articles = Article.all  # An instance variable, since view and controller both need to use it
  end # Anything we want available in the view template should be an instance variable

  def show
    @article = Article.find(params[:id]) # grabs :id from the url
    # params returns a hash of all request parameters, we've chosen "id" from among them
    
    @comment = Comment.new  # Interesting: Whenever an article is opened, we're assuming a comment will be created
    @comment.article_id = @article.id 

    # If we users @article.comments.new, we'd already have assigned the comment to the article and would see an "extra" comment

  end

  def new
    @article = Article.new # We actually need to make an article before we can reference it with our form
  
    # Just as "new" leads automatically to "create", "edit" leads automatically to "update"
  end

  def create
    @article = Article.new(article_params) # Defined further in articles_helper
    # Above is more efficient than the below
    # @article = Article.new(
    #   title: params[:article][:title]
    #   body: params[:article][:body] # This didn't work until we added the :article param first
    #   )
    @article.save
    flash.notice = "You published '#{@article.title}'!"

    redirect_to article_path(@article)  # Sends us to the show page once we're done creating
    # fail    # Adding this lets us see lots of details about the request, handy for testing
  end

  def edit
    @article = Article.find(params[:id])
    # Once we've saved our form, it looks for the "update" method, since we hit "submit"
    # on an object that already exists
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)  # "Update" method is similar to "new" -> we pass in a hash of data, and an object changes

    flash.notice = "You successfully updated '#{@article.title}'!"
        # We'll need to add thie to the view template before it works

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy 

    flash.notice = "You successfully deleted '#{@article.title}'."

    redirect_to articles_path
  end

end
