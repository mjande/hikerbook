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

  # Friend requests, which are temporary db records to indicate a pending friend request.
  # They should be deleted upon accepting request.
  has_many :received_requests, class_name: 'FriendRequest', inverse_of: :receiver, foreign_key: :receiver_id, dependent: :destroy
  has_many :requesting_friends, through: :received_requests, source: :sender

  has_many :sent_requests, class_name: 'FriendRequest', inverse_of: :sender, foreign_key: :sender_id, dependent: :destroy
  has_many :requested_friends, through: :sent_requests, source: :receiver

  # Friendships of the user (NOTE: because the association relies on the exists
  # of a friendship where the current user is listed as :user, there are two
  # records for each friendship between two users, so that each of them can be
  # listed as the :user and access their :friend)
  
  # TODO: Change friendship model so that only one instance needs to exist for
  # every friendship
  has_many :friendships, foreign_key: :user, inverse_of: :user, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
end
