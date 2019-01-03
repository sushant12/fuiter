Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'homes#index'
  get '/homes/sync', to: 'homes#sync'

  get '/editor/design/:fb_page_id', to: 'editor#design'
  get '/editor/page/:fb_page_id', to: 'editor#page'
  get '/editor/setting/:fb_page_id', to: 'editor#setting'

  get 'site/:fb_page_id/home', to: 'site#home', as: 'site_home'
  get 'site/:fb_page_id/about', to: 'site#about', as: 'site_about'
  get 'site/:fb_page_id/contact', to: 'site#contact', as: 'site_contact'
  get 'site/:fb_page_id/events', to: 'site#events', as: 'site_events'
  get 'site/:fb_page_id/gallery', to: 'site#gallery', as: 'site_gallery'
  get 'site/:fb_page_id/news', to: 'site#news', as: 'site_news'

  get '/:fb_page_id/templates', to: 'templates#index', as: 'templates'
  get '/:fb_page_id/templates/:template_id', to: 'templates#choose', as: 'choose_template'
end
