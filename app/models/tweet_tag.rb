class TweetTag < ActiveRecord::Base
    belongs_to :tag
    belongs_to :tweet

end