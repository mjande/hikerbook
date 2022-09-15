# frozen_string_literal: true

class Post < ApplicationRecord
  validates :trail, presence: true
  validates :park, presence: true
  validates :description, presence: true

  belongs_to :user

  after_create_commit -> { broadcast_prepend_later_to 'posts', locals: { user: Current.user, post: self } }
  after_update_commit -> { broadcast_replace_later_to 'posts', locals: { user: Current.user, post: self } }
  after_destroy_commit -> { broadcast_remove_to 'posts' }

  def time
    time_zone = ActiveSupport::TimeZone['Eastern Time (US & Canada)']
    created_at.in_time_zone(time_zone).strftime('%a, %B %e, %Y at %I:%M%p')
  end
end
