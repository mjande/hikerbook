# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friendships, foreign_key: :friend, inverse_of: :user, dependent: :destroy
  has_many :friends, through: :friendships, class_name: 'User'

  has_many :friend_requests, foreign_key: :sender, inverse_of: :potential_friend, dependent: :destroy
  has_many :friend_requests, foreign_key: :potential_friend, inverse_of: :sender, dependent: :destroy
end
