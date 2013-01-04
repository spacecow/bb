Bb::Application.routes.draw do
  resources :familiars, :only => [:show,:index,:create]
  resources :sales, :only => [:create,:destroy]

  root :to => 'familiars#index'
end
