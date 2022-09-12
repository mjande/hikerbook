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

  # Friend requests, which are temporary db records to indicate a pending friend
  # request. They should be deleted upon responding to request.
  has_many :received_requests, class_name: 'FriendRequest',
                               inverse_of: :receiver,
                               foreign_key: :receiver_id,
                               dependent: :destroy
  has_many :requesting_friends, through: :received_requests, source: :sender

  has_many :sent_requests, class_name: 'FriendRequest',
                           inverse_of: :sender,
                           foreign_key: :sender_id,
                           dependent: :destroy
  has_many :requested_friends, through: :sent_requests, source: :receiver

  # Friendships of the user (NOTE: :friendships indicates records where the user
  # is listed as :user. Two records should exist for each 'friendhsip', one
  # listing each user as the :user. To access each record from the other
  # direction, there is the utility association called :received_friendships.
  # See note below for plans to fix this temporary behavior).

  # TODO: Change friendship model so that only one instance needs to exist for
  # every friendship
  has_many :friendships, foreign_key: :user, inverse_of: :user, dependent: :destroy
  has_many :received_friendships, class_name: 'Friendship',
                                  foreign_key: :friend,
                                  inverse_of: :friend,
                                  dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  def sent_request?(user)
    FriendRequest.where(sender: self, receiver: user).exists?
  end

  def received_request?(user)
    FriendRequest.where(sender: user, receiver: self).exists?
  end
end
