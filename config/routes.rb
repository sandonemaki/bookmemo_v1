Rails.application.routes.draw do
  get 'memos/index'
  get "books/new" => "books#new"
  post "books/create" => "books#create"

  get "memos/new" => "memos#new"
  post "memos/create" => "memos#create"
  get "memos/index" => "memos#index"

  root to: "books#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
