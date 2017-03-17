module TagsHelper

  def tag_params
    params.require(:name)
  end

end
