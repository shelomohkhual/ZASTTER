class User < ActiveRecord::Base
  has_many :likes
  has_many :followers, :class_name => "Follower", :foreign_key => "follower_id"
  has_many :followings, :class_name => "Follower", :foreign_key => "user_id"

  has_many :tweets

    validates_presence_of :nickname :name, :email
    validates :email, uniqueness: {case_sensitive: false}
    validates :nickname, uniqueness: {case_sensitive: false}

    include BCrypt
    def password
      @password ||= Password.new(password_hash)
    end
  
    def password=(new_pass)
      @password = Password.create(new_pass)
      self.password_hash = @password
    end

    def add_tweet
      self.tweet_count += 1
    end 

    def add_following
      self.following_count += 1
    end 
    def add_follower
      self.follower_count += 1
    end 
    def add_like
      self.like_count += 1
    end 
    
  end