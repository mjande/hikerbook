class Like < ApplicationRecord
  after_commit :update_like_count


  belongs_to :post
  belongs_to :user

  def update_like_count
    Turbo::StreamsChannel.broadcast_update_later_to [Current.user, 'posts'],
                                                    partial: 'posts/likes/like_count',
                                                    target: "post_#{post.id}_like_count",
                                                    locals: { post: }
  end
end
