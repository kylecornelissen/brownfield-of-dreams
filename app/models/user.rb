# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.authenticate(id, auth_data)
    user = User.find(id)
    user.attributes = {uid: auth_data.uid,
                       username: auth_data.info.nickname,
                       token: auth_data.credentials.token}
    user.save
  end

  def potential_friend(current_user, uid)
    user = User.find_by(uid: uid)
    if user
      if !Friendship.where(user_id: current_user.id, friend_id: user.id).exists?
        true
      else
        false
      end
    else
      false
    end
  end
end
