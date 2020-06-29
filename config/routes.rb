Rails.application.routes.draw do
  get 'populations', to: 'populations#index'
  get 'the_logz', to: 'logs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
