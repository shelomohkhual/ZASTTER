class ApplicationController < Sinatra::Base
    require_relative "users_controller"
    require_relative "urls_controller"
    use UserController
    use UrlController
    
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
    @urls=Url.where(user_id: nil).last(5).reverse
    if session[:user_id]
        @user = User.find_by(id: session[:user_id])
    end
    erb :home
    
    end



end
