# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'projects#index'
resources :projects, only: [:index, :new, :create]
resources :settings, only: [:index, :new, :create]
