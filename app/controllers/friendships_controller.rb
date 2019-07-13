class FriendshipsController < ApplicationController
  def create
    friend = Friendship.new(user_id: current_user.id, friend_id: User.find_by(uid: params[:uid]))
    if !friend.save
      flash[:error] = "Invalid user id."
    end
    redirect_to dashboard_path
  end
end
