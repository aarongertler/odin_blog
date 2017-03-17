Rails.application.routes.draw do
  root to: 'articles#index'  # Setting our homepage
  resources :articles do
    resources :comments  # Creates the article_comments_path so that our form for [@articles, @comments] will work
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
