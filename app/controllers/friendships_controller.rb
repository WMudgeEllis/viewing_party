class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:find_friend])
    user = User.find(session[:user_id])
    user.friendships.create(friend_id: friend.id)
    #require "pry"; binding.pry
    redirect_to dashboard_path
  end
end
