class AddUserIdToTweets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tweets, :user,foreign_key: true, null: false
  end
end
