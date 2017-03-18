class TagsController < ApplicationController
  before_filter :require_login, except: [:show, :index] # Included in the Logins concern

  def index # This is what we'll need if we want our url/tags page to exist
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id]) # All we have to do is find the correct tag in the DB. The view does the rest.
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    flash.notice = "You successfully deleted '#{@tag.name}'."

    redirect_to tags_path
  end

end
