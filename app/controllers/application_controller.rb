require "byebug"
class ApplicationController < Sinatra::Base
    require_relative "session_controller"
   
    use SessionController
   
    
    register Sinatra::ActiveRecordExtension

    configure do
        set :views, "app/views"
    set :public_dir, "public"
    #enables sessions as per Sinatra's docs. Session_secret is meant to encript the session id so that users cannot create a fake session_id to hack into your site without logging in. 
    enable :sessions
    set :session_secret, "secret"
    end


    # Renders the home or index page
    get '/' do
       
    erb :home , layout: :'/layouts/sessions_layout'
    
    end
end


