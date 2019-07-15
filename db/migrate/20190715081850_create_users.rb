class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :name
      t.string :email
      t.string :password_hash
      t.integer :tweet_count
      t.integer :following_count
      t.integer :follower_count
      t.integer :like_count
      

      t.timestamp
    end
  end
end
