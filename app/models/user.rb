class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }


  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends, through: :friendships

  def request_friend(another_user)
    friends << another_user
  end

  def is_friend?(another_user)
    friends.include?(another_user)
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.confirmed}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{ |friendship| friendship.user == user }
    friendship.confirmed = true
    friendship.save
  end

end
