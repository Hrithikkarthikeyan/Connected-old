class FriendshipsController < ApplicationController
  def create
    friend = Account.find(params[:friend])
    account = Account.find(params[:account])
    request = Request.find_by(account_id: account.id,friend_id: friend.id)
    request.status = 1
    request.save
    current_account.friendships.build(friend_id: account.id)
    if current_account.save
      flash[:notice] = "Connected successfully"
    else
      flash[:alert] = "There was something wrong with the tracking request"
    end
    redirect_to my_friends_path
  end
  
  def destroy
    friendship = current_account.friendships.where(friend_id: params[:id]).first
    # Request.find_by(account_id: current_account.id,friend_id: params[:id]).destroy
    friendship.destroy
    flash[:notice] = "Stopped, following"
    redirect_to my_friends_path
  end
end
  