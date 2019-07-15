class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.integer :tweet_id
      t.integer :reply_id
      
      t.timestamp
    end
  end
end
