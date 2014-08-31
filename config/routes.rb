Rails.application.routes.draw do
  root to: 'home#index'
  get '/:path', to: 'walls#show', as: 'wall'
  post '/:path', to: 'walls#update', as: 'wall_update'
  get '/:path/*other', to: redirect(path: '%{path}')
end
