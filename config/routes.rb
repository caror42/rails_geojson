Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  match 'inside', to: 'application#inside', via: :post
  match 'boundary', to: 'application#boundary', via: :post
  match 'boundary/:name', to: 'application#get_boundary', via: :get
  match 'boundary/:name', to: 'application#delete_boundary', via: :delete
  match 'inside/:name', to: 'application#inside_by_name', via: :post
  #match 'circle', to 'application#circle', via: :post
end
