class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:find_friend])
    user = User.find(session[:user_id])
    if friend
      user.friendships.create(friend_id: friend.id)
    else
      flash[:error] = 'User does not exist'
    end
    redirect_to dashboard_path
  end
end
