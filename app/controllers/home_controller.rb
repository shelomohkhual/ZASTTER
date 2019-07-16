class HomeController  < Sinatra::Base


   configure do
       set :views, "app/views"
   set :public_dir, "public"
   end
   register Sinatra::ActiveRecordExtension

 # Renders the user's individual home/account page.
 get '/users/home' do
  # byebug
   @user = User.find(session[:user_id])
   @tweets = @user.tweets
    erb :'/users/user_home', layout: :'/layouts/users_home_layout'
end


post '/tweet' do
       @tweet=Tweet.create(text:params["tweet"] ,liked_count:0,reply_count:0,retweet_count: 0,user_id: session[:user_id] )
       redirect '/users/user_home'
end

end