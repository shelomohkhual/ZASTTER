class Tweet < ActiveRecord::Base
    belongs_to :user
    has_many :likes
    has_many :tweets_tags

    has_many :tweets, :class_name => "Reply", :foreign_key => "tweet_id"
    has_many :replies, :class_name => "Reply", :foreign_key => "reply_id"

    has_many :tweets, :class_name => "Retweet", :foreign_key => "tweet_id"
    has_many :retweets, :class_name => "Retweet", :foreign_key => "retweet_id"

    

end