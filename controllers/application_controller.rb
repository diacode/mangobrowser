# Application wide settings
# Other controllers should use this

class ApplicationController < Sinatra::Base
  register Sinatra::Contrib
  register Sinatra::Sprockets::Helpers
  helpers ApplicationHelper
  use Rack::Flash

  config_file '../config/config.yml'

  enable :method_override
  enable :sessions
  set :root, File.expand_path('../../', __FILE__)
  set :session_secret, ENV['SESSION_SECRET']

  # Enable SSL
  set :use_ssl, true

  configure :production do
    use Rack::SSL if settings.use_ssl
  end

  not_found do
    haml :not_found, layout: false
  end

  get %r{(\/.*[^\/])$} do
    redirect to "#{params[:captures].first}/"
  end

  get '/' do
    haml :home, layout: :homepage
  end

  get '/login/?' do
    haml :home, layout: :homepage
  end

  %w(terms faq privacy).each do |page|
    get "/#{page}/?" do
      haml page.intern
    end
  end

  get '/logout/?' do
    session.clear
    flash[:alert] = "You have logged out."
    redirect '/'
  end

  post '/login' do
    session[:mangopay_client_id] = params[:mangopay_client_id].empty? ? nil : params[:mangopay_client_id].strip
    session[:mangopay_client_passphrase] = params[:mangopay_client_passphrase].empty? ? nil : params[:mangopay_client_passphrase].strip
    session[:mangopay_preproduction] = params[:mangopay_preproduction] == 'true' ? true : false
    validate_credentials
    redirect '/resources/users/'
  end
end
