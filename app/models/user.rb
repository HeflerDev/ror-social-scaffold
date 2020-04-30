class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends, through: :friendships

  def request_friend(another_user)
    friends << another_user
  end

  # rubocop:disable Naming/PredicateName

  def is_friend?(another_user)
    friends.include?(another_user)
  end

  def is_friended?(another_user)
    inverse_friends.include?(another_user)
  end

  # rubocop:enable Naming/PredicateName

  def friend_is_confirmed?(another_user)
    friendships.find_by(friend_id: another_user).confirmed
  end

  def user_is_confirmed?(user)
    inverse_friendships.find_by(user_id: user).confirmed
  end

  # Users who have yet to confirm friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.confirmed = true
    friendship.save
  end
end
