class RequestsController < ApplicationController
  def index
    @requests = Request.all.includes(:account, :friend).order(created_at: :desc)
    
  end
  def create
    request = Account.find(params[:friend])
    current_account.requests.build(friend_id: request.id, status: 0)
    if current_account.save
      flash[:notice] = "Request Sent"
    else
      flash[:alert] = "There was something wrong with the tracking request"
    end
    redirect_to my_friends_path
  end

  def destroy
    # request = current_account.requests.where(id: params[:request_id]).first
    
    request = Request.find(params[:request_id])
    request.destroy
    flash[:notice] = "request destroyed"
    redirect_to my_friends_path
  end

  def update

  end
end
