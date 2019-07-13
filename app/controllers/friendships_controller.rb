# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    friend = Friendship.new(user_id: current_user.id, friend_id: User.find_by(uid: params[:uid]).id)
    flash[:error] = 'Invalid user id.' unless friend.save
    redirect_to dashboard_path
  end
end
