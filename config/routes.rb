Rails.application.routes.draw do
  root to: 'articles#index'  # Setting our homepage

  get 'login' => 'author_sessions#new'
    # This means that you can go to url/login to log in, rather than url/author_sessions/new
  get 'logout' => 'author_sessions#destroy'
  get '/articles/popular' => 'articles#popular_index'
  # get 'feed' => 'articles#feed'

  resources :articles do
    resources :comments  # Creates the article_comments_path so that our form for [@articles, @comments] will work
  end

  resources :tags # Not part of articles/do, since we want to be able to look at tags as independent objects (whereas all comments are connected to an article)
  resources :authors

  resources :author_sessions, only: [ :new, :create, :destroy ]
    # No need to update session data, provide an index of sessions, etc.

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # ^^^ This really helps!
end
