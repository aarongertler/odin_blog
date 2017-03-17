module ArticlesHelper

  def article_params
    params.require(:article).permit(:title, :body)
    # Without require and permit, we don't have Strong Parameters and will run into trouble
    # This way, we aren't blindly saving any parameter someone tries to give our site!
  end

end
