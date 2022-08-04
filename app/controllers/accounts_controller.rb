class AccountsController < ApplicationController
  before_action :authenticate_account! 
   
  def my_friends
    @friends = current_account.friends 
    @requests = Request.where(account_id: current_account, status: 0)
    # @left_account = Account.where(id: Friendship.where(friend_id: current_account).select(:account_id))
  end

  def search_new
    @accounts = Account.where.not(id: current_account)
    @first_friends = current_account.friends
    @second_friends = []
    @first_friends.each do |friend|
      friend.friends.each do |fr|
        @second_friends.append(fr)
      end 
    end
    @second_friends = @second_friends.uniq
    @suggested_accounts = []
    @accounts.each do |account|
      if !(Friendship.where(account_id: current_account,friend_id: account).exists? || Request.where(account_id: current_account, friend_id: account, status: 0).exists? || 
            Request.where(account_id: account, friend_id: current_account, status: 0).exists?)
        @suggested_accounts.append(account)
      end
    end
    # @suggested_accounts = @suggested_accounts.sample(4)
    temp = @suggested_accounts
    @suggested_accounts = @second_friends & @suggested_accounts
    if @suggested_accounts.count == 0
      @suggested_accounts = temp
    end 
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
    if !(current_account == @acc) 
      if (View.where(account_id: current_account.id, friend_id: @acc.id).exists?)
        view = View.find_by(account_id: current_account.id, friend_id: @acc.id)
        view.created_at = Time.now
        view.save
      else
        View.create(account_id: current_account.id,friend_id: @acc.id )
      end
    end
    @posts = @acc.posts.order('created_at DESC')
    @friend = Friendship.find_by(account_id: @acc.id)
  end

  def my_account
    
  end
  
end
