class AccountsController < ApplicationController
  before_action :authenticate_account!
   
  def my_friends
    @friends = current_account.friends
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
    @posts = @acc.posts
  end

  def my_account
    
  end
end
