class HomeController  < Sinatra::Base


   configure do
       set :views, "app/views"
   set :public_dir, "public"
   end
   register Sinatra::ActiveRecordExtension


 get '/users/home' do
    if session[:user_id] == nil
        redirect ‘/sessions/login’
      else
      
        # byebug
        @user = User.find(session[:user_id])
        @tweets = @user.tweets.reverse
        @random_users = []
            3.times do
                x = User.find(rand(User.count) + 1)
                while x == @user || @random_users.include?(x)
                    x = User.find(rand(User.count) + 1)
                end
                (@random_users << x)
            end
        #    @random_users = User.all.sample(3)
            erb :'/users/user_home', layout: :'/layouts/users_home_layout'
        end
    # 




end


post '/tweet' do
       @tweet=Tweet.create(text:params["tweet"] ,liked_count:0,reply_count:0,retweet_count: 0,user_id: session[:user_id] )
       redirect '/users/home'
end

get '/users/:id' do
     @other_user = User.find(params[:id])
     @tweets = @other_user.tweets.reverse
      erb :'/users/profile_home', layout: :'/layouts/users_home_layout'
      
  end

end