class AddIndexToSenderAndPotentialFriendInFriendRequests < ActiveRecord::Migration[7.0]
  def change
    add_index :friend_requests, [:sender_id, :potential_friend_id], unique: true
  end
end
