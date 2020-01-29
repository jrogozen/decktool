require './app'

set :protection, :except => :json_csrf
set :bind, '0.0.0.0'

run Sinatra::Application