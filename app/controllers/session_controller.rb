require "byebug"
class SessionController  < Sinatra::Base

 register Sinatra::ActiveRecordExtension
    configure do
        set :views, "app/views"
    set :public_dir, "public"
    end


  # Renders the sign up/registration page in app/views/registrations/signup.erb
  get '/registrations/signup' do
    erb :'/registrations/signup' , layout: :'/layouts/sessions_layout'
  end

  # Handles the POST request when user submits the Sign Up form. Get user info from the params hash, creates a new user, signs them in, redirects them. 
  post '/registrations' do
    # byebug

   user = User.create(nickname: params["nickname"],name: params["name"], email: params["email"])
   #byebug
   if user.valid? 
   user.password= params["password"]
   user.save
   session[:user_id] = user.id 
   redirect 'users/home' 
   else
    @nickname_error=user.errors.messages[:nickname][0]
    @email_error=user.errors.messages[:email][0]
    erb :'/registrations/signup' , layout: :'/layouts/sessions_layout'
   end
  end
   #---------------------------------------------------------------------------------
 # Renders the view page in app/views/sessions/login.erb
 get '/sessions/login' do
 # byebug
    unless session[:user_id]
    erb :'/sessions/login', layout: :'/layouts/sessions_layout'
    else
    redirect '/users/home' 
    end
end


  # Handles the POST request when user submites the Log In form. Similar to above, but without the new user creation.
  post '/sessions' do
    user = User.find_by(email: params["email"])
   # byebug
    if user.password==params["password"]
    # unless user.nil?
    session[:user_id] = user.id
    redirect 'users/home' 
    else
      redirect 'sessions/login' 
    end
  end
 #---------------------------------------------------------------------------------
   # Logs the user out by clearing the sessions hash.
   get '/sessions/logout' do
    session.clear
    redirect '/'
  end


  # Renders the user's individual home/account page. 
  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/user_home', layout: :'/layouts/users_home_layout'
  end

  get '/users/profile' do

  erb :'/users/profile_home', layout: :'/layouts/users_home_layout'
  end




end
