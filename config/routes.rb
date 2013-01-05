Bb::Application.routes.draw do
  resources :familiars, :only => [:show,:index,:create]
  resources :sales, :only => [:create,:edit,:update,:destroy]

  root :to => 'familiars#index'
end
