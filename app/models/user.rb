# frozen_string_literal: true

class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  
  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
                     file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

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

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def friends
    friends_as1 + friends_as2
  end

  def potential_friends
    User.where.not(id: [friends]).where.not(id: [requesting_friends]).where.not(id: [requested_friends]).where.not(id:)
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

  # For use with omniauth, see https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def avatar_pic
    avatar.attached? ? avatar.variant(resize_to_fill: [48, 48]) : gravatar_url
  end

  # https://stackoverflow.com/questions/14361952/rails-gravatar-helper-method
  def gravatar_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=retro"
  end
end
