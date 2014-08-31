Rails.application.routes.draw do
  root to: 'home#index'
  get '/:path', to: 'walls#show'
  post '/:path', to: 'walls#update'
  get '/:path/*other', to: redirect(path: '%{path}')
end
