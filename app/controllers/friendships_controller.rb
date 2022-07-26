class FriendshipsController < ApplicationController
  def create
    friend = Account.find(params[:friend])
    current_account.friendships.build(friend_id: friend.id)
    if current_account.save
      flash[:notice] = "Connected successfully"
    else
      flash[:alert] = "There was something wrong with the tracking request"
    end
    redirect_to my_friends_path
  end

  def destroy
    friendship = current_account.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Stopped, following"
    redirect_to my_friends_path
  end
end
  