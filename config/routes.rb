Rails.application.routes.draw do
	root 'static_pages#home'
	get '/contact', to: 'static_pages#contact'
	get '/about', to: 'static_pages#about'
	get '/help', to: 'static_pages#help'
	get '/signup', to: 'users#new'
	post '/signup',  to: 'users#create'
	resources :microposts
	resources :users
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end