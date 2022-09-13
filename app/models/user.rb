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
  # is listed as :user. Two records should exist for each 'friendship', one
  # listing each user as the :user. To access each record from the other
  # direction, there is the utility association called :received_friendships.
  # See note below for plans to fix this temporary behavior).

  # TODO: Change friendship model so that only one instance needs to exist for
  # every friendship
  has_many :friendships_as1, class_name: 'Friendship',
                             foreign_key: :user1_id,
                             inverse_of: :user1,
                             dependent: :destroy
  has_many :friends_as1, through: :friendships_as1, source: :user2
  has_many :friendships_as2, class_name: 'Friendship',
                             foreign_key: :user2_id,
                             inverse_of: :user2,
                             dependent: :destroy
  has_many :friends_as2, through: :friendships_as2, source: :user1

  def friends
    friends_as1 + friends_as2
  end

  def sent_request?(user)
    FriendRequest.where(sender: self, receiver: user).exists?
  end

  def received_request?(user)
    FriendRequest.where(sender: user, receiver: self).exists?
  end

  def friendship(user)
    Friendship.find_by(user1_id: self, user2_id: user) ||
      Friendship.find_by(user1_id: user, user2_id: self)
  end
end
