# frozen_string_literal: true
Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
 
  mount StripeEvent::Engine, at: '/webhook'
  
  constraints(Subdomain.new) do
    match '/', to: 'site#home', via: [:get]
    get '/about', to: 'site#about'
    get '/news', to: 'site#news'
    get '/gallery', to: 'site#gallery'
    get '/events', to: 'site#events'
    get '/contact', to: 'site#contact'
    get '/gallery/:album_id', to: 'site#photo_albums', as: 'photo_albums'
    get '/terms_and_condition', to: 'site#terms_condition'
    get '/privacy_policy', to: 'site#privacy_policy'
  end
  
  resources :pages, except: [:new, :edit] 
  resources :fb_page, only: [:index] do
    resources :subscription, only: [:new, :create, :destroy]
    put 'sync', to: 'fb_page#sync', as: 'sync'
    get '/billing', to: 'billing#billing_history', as: 'billing_history'
  end
  resources :fb_page_template, only: [:show, :update]
  resources :billing, only: [:index]
  resources :dashboard, only: [:index]

  # get '/billing', to: 'billing#index', as: 'billing'
  # get '/checkout/:id', to: 'subscription#index', as: 'checkout'
  # post '/subscribe', to: 'subscription#create', as: 'subscribe'
  # put '/cancel_subscription/:fb_page_id', to: 'subscription#cancel_subscription', as: 'cancel_subscription'
  
  # get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  # post '/dashboard/sync/:id', to: 'dashboard#sync', as: 'sync_page'

  scope :editor do
    get 'design/:fb_page_id', to: 'editor#design', as: 'editor_design'
    get 'template/pages/:fb_page_id', to: 'editor#list_pages'
    put 'page/:fb_page_id', to: 'editor#page'
    post 'setting/:fb_page_id', to: 'editor#create_setting', as: 'editor_create_setting'
    get ':fb_page_id/setting/:fb_page_template_id', to: 'editor#show_setting', as: 'editor_show_setting'
  end
  
  scope :site do
    get ':fb_page_id/home', to: 'site#home', as: 'site_home'
    get ':fb_page_id/about', to: 'site#about', as: 'site_about'
    get ':fb_page_id/contact', to: 'site#contact', as: 'site_contact'
    post ':fb_page_id/contact', to: 'site#send_contact_message', as: 'site_contact_post'
    get ':fb_page_id/events', to: 'site#events', as: 'site_events'
    get ':fb_page_id/gallery', to: 'site#gallery', as: 'site_gallery'
    get ':fb_page_id/gallery/:album_id', to: 'site#photo_albums', as: 'site_photo_albums'
    get ':fb_page_id/privacy_policy', to: 'site#privacy_policy', as: 'site_privacy_policy'
    get ':fb_page_id/terms_condition', to: 'site#terms_condition', as: 'site_terms_condition'
    get ':fb_page_id/news', to: 'site#news', as: 'site_news'
  end

  put '/:fb_page_id/templates/:id/properties', to: 'templates#properties', as: 'properties'
  get '/:fb_page_id/templates', to: 'templates#index', as: 'templates'
  post '/:fb_page_id/templates/:template_id', to: 'templates#choose', as: 'choose_template'
  
  root to: 'home#index'
end
