# frozen_string_literal: true

# The Like model represents a user liking another's post. Each post displays the
# total number of likes from the creator's friends, indicating the post's
# overall popularity.
class Like < ApplicationRecord
  after_commit :update_like_count

  belongs_to :post
  belongs_to :user

  def update_like_count
    return unless Current.user

    Current.user.friends.each do |friend|
      Turbo::StreamsChannel.broadcast_update_later_to friend,
                                                      partial: 'posts/likes/like_count',
                                                      target: "post_#{post.id}_like_count",
                                                      locals: { post: }
    end
  end
end
