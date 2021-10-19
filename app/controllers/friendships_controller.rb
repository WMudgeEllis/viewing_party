class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:find_friend])
    user = User.find(current_user.id)
    if user.friend?(params[:find_friend])
      flash[:error] = 'This user is already your friend.'
    elsif params[:find_friend] == user.email
      flash[:error] = "You can't add yourself as a friend!"
    elsif friend
      user.friendships.create!(friend_id: friend.id)
    else
      flash[:error] = 'User does not exist'
    end
    redirect_to dashboard_path
  end
end
