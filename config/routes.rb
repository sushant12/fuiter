Rails.application.routes.draw do
  root to: 'homes#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
