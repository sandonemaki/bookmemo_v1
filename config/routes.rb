Rails.application.routes.draw do
  get "books/new" => "books#new"
  get "books/:id" => "books#show"
  post "books/create" => "books#create"
  post "books/:id/page_image_update" => "books#page_image_update"

  get "memos/new" => "memos#new"
  post "memos/create" => "memos#create"
  get "memos/index" => "memos#index"

  root to: "books#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
