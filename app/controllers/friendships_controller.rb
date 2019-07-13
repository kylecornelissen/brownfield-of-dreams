class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(uid: params[:uid])
    Friendship.create(user_id: current_user.id, friend_id: friend.id)
    if !friend.save
      flash[:error] = "Invalid user id."
    end
    redirect_to dashboard_path
  end
end
