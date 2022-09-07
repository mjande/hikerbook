# frozen_string_literal: true

class Post < ApplicationRecord
  validates :trail, presence: true
  validates :park, presence: true
  validates :description, presence: true
  

  belongs_to :user
end
