Rails.application.routes.draw do
  resources :users
  post   "/login"       => "sessions#create"
  delete "/logout"      => "sessions#destroy"
end
