# frozen_string_literal: true

class AddIndexToSenderAndReceiverInFriendRequests < ActiveRecord::Migration[7.0]
  def change
    add_index :friend_requests, %i[sender_id receiver_id], unique: true
  end
end
