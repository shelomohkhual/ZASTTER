class Reply < ActiveRecord::Base

    belongs_to :tweet, :class_name => "Tweet", :foreign_key => "tweet_id"
    belongs_to :reply, :class_name => "Tweet", :foreign_key => "reply_id"
    

end