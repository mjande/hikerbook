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

  # Friendships of the user (NOTE: Because the order of attributes is set based
  # on who sent the friend request, there are two associations included to make
  # friendships work for either order. These two associations are combined in
  # the #friends method below.)
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

  def sent_request_to(user)
    FriendRequest.find_by(sender: self, receiver: user)
  end

  def received_request_from(user)
    FriendRequest.find_by(sender: user, receiver: self)
  end

  def friendship_with(user)
    Friendship.find_by(user1_id: self, user2_id: user) ||
      Friendship.find_by(user1_id: user, user2_id: self)
  end
end
