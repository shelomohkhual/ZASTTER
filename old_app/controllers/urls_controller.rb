require "byebug"
class UrlController < Sinatra::Base

    require "open-uri"
    
    register Sinatra::ActiveRecordExtension

    configure do
        set :views, "app/views"
        set :public_dir, "public"
        #enables sessions as per Sinatra's docs. Session_secret is meant to encript the session id so that users cannot create a fake session_id to hack into your site without logging in. 
        enable :sessions
        set :session_secret, "secret"
    end

    def validate_url(str)
        state = []
        begin
            if str.first(4).downcase == "http"
                state = open(str).status
            else
                state = open("http://"+str).status
            end
        rescue StandardError => e
           return "Bad Url"
        end

        if state[0] =="200"
            get_short
        else
            return "Please enter a valid website address"
        end
    end

    def get_short
        a = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
        url = ""
        loop do
            puts "test1"
            url = ""
            puts "test2"
            6.times {url << a[rand(a.length)]}
            puts "test3"
            break unless Url.select(:short_url).any?{|entry| entry.short_url == url } 
        end
        puts url
        return url
        
    end

    def get_user_id
        if session[:user_id]
            session[:user_id]
        else
            nil
        end
    end

    post '/urls' do
        session[:short_url] = validate_url(params["long_url"]) 
        if session[:short_url] != "Bad Url"
            Url.create(long_url: params["long_url"], visits: 0, user_id:get_user_id, short_url: session[:short_url]  )
        end
        session[:user_id] ? (redirect "/users/home") : (redirect "/")
            

    end
   


    get "/:short" do
        entry = Url.find_by(short_url: params[:short])
        long_url = entry.long_url
        entry.visits  += 1
        entry.save
        if long_url.starts_with?("http") || long_url.starts_with?("ftp")
            redirect long_url
        else
            redirect "http://www.#{long_url}"
        end
    end

        # deletes the selected url 
        delete '/users/home/:id' do
            Url.find(params[:id]).destroy
            redirect :'/users/home'
          end
      
          # updates the selected url 
          put '/users/home/:id' do
            url = Url.find(params[:id])
            url.visits = 0
            url.short_url = validate_url(url.long_url) 
            url.save
            redirect :'/users/home'
          end
      
    
end
