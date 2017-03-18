module Logins
  extend ActiveSupport::Concern

  def require_login
    unless current_user
      redirect_to root_path
      return false
    end
  end

end

class AuthorsController < ApplicationController
  include Logins
end

class TagsController < ApplicationController
  include Logins
end

class CommentsController < ApplicationController
  include Logins
end