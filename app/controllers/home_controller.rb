class HomeController  < Sinatra::Base


   configure do
       set :views, "app/views"
   set :public_dir, "public"
   end
   register Sinatra::ActiveRecordExtension

 get '/users/home' do
    if session[:user_id] != nil
        @user = User.find(session[:user_id])
        @tweets = @user.tweets.reverse
        @random_users = User.all
        # @random_users.times do |user|
        #   if user.id == @user.id

        # end
        # @random_users.find_by(nickname: @user.nickname).destroy
        erb :'/users/user_home', layout: :'/layouts/users_home_layout'
      else
        redirect "/sessions/login"
      end
    end

post '/tweet' do
       @tweet=Tweet.create(text:params["tweet"] ,liked_count:0,reply_count:0,retweet_count: 0,user_id: session[:user_id] )
       redirect '/users/home'
end

get '/:nickname' do
    if session[:user_id] != nil
        @user = User.find(session[:user_id])
        @other_user = User.find_by(nickname: params[:nickname])
        @tweets = @other_user.tweets.reverse
        # byebug
        if session[:user_id]!= @user.id
            @other_user = @user
        else nil
        end
    
      erb :'/users/profile_home', layout: :'/layouts/users_home_layout'
    else redirect '/sessions/login'
    end
  end

end