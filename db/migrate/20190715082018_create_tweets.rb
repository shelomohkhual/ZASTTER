class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :text, :limit => 140, :null => false
      t.integer :liked_count
      t.integer :reply_count
      t.integer :retweet_count
      
      t.timestamp
    end
  end
end
