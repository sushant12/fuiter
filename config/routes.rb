# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'home#index'
  resources :pages, except: [:new, :edit]
  resources :fb_page_template, only: [:show, :update]
  post '/home/sync/:id', to: 'home#sync', as: 'sync_page'

  get '/editor/design/:fb_page_id', to: 'editor#design', as: 'editor_design'
  put '/editor/page/:fb_page_id', to: 'editor#page'
  post '/editor/setting/:fb_page_id', to: 'editor#create_setting', as: 'editor_create_setting'
  get '/editor/setting/:fb_page_template_id', to: 'editor#show_setting', as: 'editor_show_setting'

  get 'site/:fb_page_id/home', to: 'site#home', as: 'site_home'
  get 'site/:fb_page_id/about', to: 'site#about', as: 'site_about'
  get 'site/:fb_page_id/contact', to: 'site#contact', as: 'site_contact'
  post 'site/:fb_page_id/contact', to: 'site#send_contact_message', as: 'site_contact_post'
  get 'site/:fb_page_id/events', to: 'site#events', as: 'site_events'
  get 'site/:fb_page_id/gallery', to: 'site#gallery', as: 'site_gallery'
  get '/site/:fb_page_id/gallery/:album_id', to: 'site#photo_albums', as: 'site_photo_albums'

  get 'site/:fb_page_id/news', to: 'site#news', as: 'site_news'

  put '/:fb_page_id/templates/:id/properties', to: 'templates#properties', as: 'properties'
  get '/:fb_page_id/templates', to: 'templates#index', as: 'templates'
  post '/:fb_page_id/templates/:template_id', to: 'templates#choose', as: 'choose_template'
end
