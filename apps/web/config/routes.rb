# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/faq', to: 'static#faq', as: :faq
get '/contributors/:id', to: 'contributors#show'
root to: 'contributors#index'
