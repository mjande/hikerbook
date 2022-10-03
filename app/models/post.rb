# frozen_string_literal: true

class Post < ApplicationRecord
  validates :trail, presence: true
  validates :park, presence: true
  validates :description, length: { maximum: 280 }

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [48, 48]
    attachable.variant :post, resize_to_fit: [1080, 1920]
  end

  # User variable is set to nil to disable controls in broadcasted posts. _post
  # and post/controls partial both depend on knowing who the current user is,
  # but based on current implementation of Turbo Streams (which wraps the
  # broadcasts for Active Job), there isn't a way to pass current_user to these
  # partials effectively.
  after_create_commit :broadcast_prepend_post
  after_update_commit :broadcast_update_post
  after_destroy_commit :broadcast_remove_post

  def time
    time_zone = ActiveSupport::TimeZone['Eastern Time (US & Canada)']
    created_at.in_time_zone(time_zone).strftime('%a, %B %e, %Y at %I:%M %p')
  end

  def liked_by(user)
    likes.find_by(user:)
  end

  private

  def broadcast_prepend_post
    # Guard clause to return when populating database (w/o a current user)
    return unless Current.user

    Current.user.friends.each do |friend|
      broadcast_prepend_later_to friend,
                                 target: 'posts',
                                 locals: { user: friend, post: self }
    end
  end

  def broadcast_update_post
    # Guard clause to return when populating database (w/o a current user)
    return unless Current.user
    
    Current.user.friends.each do |friend|
      broadcast_replace_later_to friend, locals: { user: friend, post: self }
    end
  end

  def broadcast_remove_post
    # Guard clause to return when populating database (w/o a current user)
    return unless Current.user
    
    Current.user.friends.each do |friend|
      broadcast_remove_to friend
    end
  end
end
