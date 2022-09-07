# frozen_string_literal: true

class Post < ApplicationRecord
  validates :trail, presence: true
  validates :park, presence: true
  validates :description, presence: true

  belongs_to :user

  def time
    time_zone = ActiveSupport::TimeZone['Eastern Time (US & Canada)']
    created_at.in_time_zone(time_zone).strftime('%a, %B %e, %Y at %I:%M%p')
  end
end
