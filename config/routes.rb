Rails.application.routes.draw do
	root 'static_pages#home'
	get '/contact', to: 'static_pages#contact'
	get '/about', to: 'static_pages#about'
	get '/help', to: 'static_pages#help'
	get '/signup', to: 'users#new'
	get '/users', to: 'users#index'
	post '/signup',  to: 'users#create'
	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'
	get '/password_resets/new', to: 'password_resets#new'
	post '/password_resets', to: 'password_resets#create'

	resources :users
	resources :account_activations, 	only: [:edit]
	resources :password_resets, 		only: [:new, :create, :edit, :update]
	resources :microposts,				only: [:create, :destroy]
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end