# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/', to: 'projects#index', as: :projects
get '/settings', to: 'settings#index', as: :settings
get '/settings/new', to: 'settings#new', as: :new_settings
post '/settings/create', to: 'settings#create', as: :create_settings
