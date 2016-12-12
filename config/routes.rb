Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :uploads
  root to: 'uploads#index'
  post '/matched_uploads', to: 'uploads#matched_uploads'
end
