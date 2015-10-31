Rails.application.routes.draw do
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    namespace :v1 do
      resources :children, only:[:index, :show]
    end
  end
end
