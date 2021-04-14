Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :schools
    end
  end

  post 'refresh', controller: :refresh, action: :create
  post 'sign_in', controller: :sign_in, action: :create
  post 'sign_up', controller: :sign_up, action: :create
  delete 'sign_in', controller: :sign_in, action: :destroy
end
