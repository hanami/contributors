get '/graphql', to: 'graphql#index'
resources :contributors, only: %i[index show]
