class FriendshipsController < ApplicationController
  def create
    friend = Account.find(params[:friend])
    account = Account.find(params[:account])
    if !account.company?
      request = Request.find_by(account_id: account.id,friend_id: friend.id)
      request.status = 1
      request.save
    end
    Friendship.create(account_id: friend.id, friend_id: account.id)
    if !account.company?
      Friendship.create(account_id: account.id, friend_id: friend.id)
    end
    flash[:notice] = "Connected Successfully"
    # if friendship.save
    #   flash[:notice] = "Connected successfully"
    # else
    #   flash[:alert] = "There was something wrong with the tracking request"
    # end
    # current_account.friendships.build(friend_id: account.id)
    # if current_account.save
    #   flash[:notice] = "Connected successfully"
    # else
    #   flash[:alert] = "There was something wrong with the tracking request"
    # end

    redirect_to my_friends_path
  end
  
  def destroy
    friendship = current_account.friendships.where(friend_id: params[:id]).first
    acc = Account.find_by(params[:id])
    if !acc.company?
      friendship2 = Friendship.find_by(account_id: params[:id], friend_id: current_account)
      friendship2.destroy
    end
    # Request.find_by(account_id: current_account.id,friend_id: params[:id]).destroy
    friendship.destroy
    flash[:notice] = "Stopped, following"
    redirect_to my_friends_path
  end
end
  