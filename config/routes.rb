Rails.application.routes.draw do
  get '/reviews' => 'reviews#index', as: :reviews
  put '/reviews/:id' => 'reviews#update', as: :update_review
end
