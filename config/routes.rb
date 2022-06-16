Rails.application.routes.draw do
  get "books/new" => "books#new"
  get "books/:id" => "books#show"
  post "books/create" => "books#create"
  #   "/books/1  /page_images/create"
  post "books/:id/page_images/create" => "books/page_images#create"
  # books/:id/page_images/:id/destroy
  namespace :books do
    resources :page_images, only: [:destroy]
  end

  get "memos/new" => "memos#new"
  post "memos/create" => "memos#create"
  get "memos/index" => "memos#index"

  root to: "books#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
