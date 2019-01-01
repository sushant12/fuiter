Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'homes#index'
  get ':fb_page_id/editor/design', to: 'editor#design'
  get ':fb_page_id/editor/page', to: 'editor#design'
  get ':fb_page_id/editor/setting', to: 'editor#design'
end
