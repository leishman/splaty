Rails.application.routes.draw do
  root to: 'home#index'
  get '/:path', to: 'walls#show', as: 'wall'
  put '/:path', to: 'walls#update', as: 'wall_update'
  post '/:path/command', to: 'walls#command', as: 'command'
  get '/:path/*other', to: redirect(path: '%{path}')

end
