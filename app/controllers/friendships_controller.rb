class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:find_friend])
    user = User.find(current_user.id)
    friend_flow(params[:find_friend], friend, user)
    redirect_to dashboard_path
  end

  private

  def friend_flow(find_friend, friend, user)
    if user.friend?(find_friend)
      flash[:error] = 'This user is already your friend.'
    elsif find_friend == user.email
      flash[:error] = "You can't add yourself as a friend!"
    elsif friend
      user.friendships.create!(friend_id: friend.id)
    else
      flash[:error] = 'User does not exist'
    end
  end
end
