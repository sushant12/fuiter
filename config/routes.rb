Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'homes#index'
  get '/editor/design/:fb_page_id', to: 'editor#design'
  get '/editor/page/:fb_page_id', to: 'editor#page'
  get '/editor/setting/:fb_page_id', to: 'editor#setting'

  get 'site/:fb_page_id/home', to: 'site#home'
  get 'site/:fb_page_id/about', to: 'site#about'
  get 'site/:fb_page_id/contact', to: 'site#contact'
  get 'site/:fb_page_id/events', to: 'site#events'
  get 'site/:fb_page_id/gallery', to: 'site#gallery'
  get 'site/:fb_page_id/news', to: 'site#news'

  get '/:fb_page_id/templates', to: 'homes#templates', as: 'templates'
end
