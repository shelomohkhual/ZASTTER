class Retweet < ActiveRecord::Base

    belongs_to :tweet, :class_name => "Tweet", :foreign_key => "tweet_id"
    belongs_to :retweet, :class_name => "Tweet", :foreign_key => "retweet_id"
    

end