# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/statistics/:github', to: 'statistics#show'
get '/contributors/:id', to: 'contributors#show'
root to: 'contributors#index'
