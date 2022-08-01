class AccountsController < ApplicationController
  before_action :authenticate_account! 
   
  def my_friends
    @friends = current_account.friends 
    # @left_account = Account.where(id: Friendship.where(friend_id: current_account).select(:account_id))
  end

  def view_connections
    @account1 = Account.find(params[:account_id])
    @friends = @account1.friends
  end

  def search
    if params[:friend].present?
      @friends = Account.search(params[:friend])
      @friends = current_account.except_current_account(@friends)
      if @friends.count > 0 
        respond_to do |format|
          format.js { render partial: 'accounts/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "No Results Found"
          format.js { render partial: 'accounts/friend_result' }
        end
      end    
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'accounts/friend_result' }
      end
    end
  end

  def show
    @acc = Account.find(params[:id])
    
      View.create(account_id: current_account.id,friend_id: @acc.id )
    
    @posts = @acc.posts.order('created_at DESC')
    @friend = Friendship.find_by(account_id: @acc.id)
  end

  def my_account
    
  end
  
end
