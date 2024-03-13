Rails.application.routes.draw do
  #users
  devise_for :users, skip: %i[registrations sessions passwords]

  devise_scope :user do
    post '/signup', to: 'registrations#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  scope path: "/api" do
  
  end
end
