class ViewsController < ApplicationController
  def index
    @views = View.where(friend_id: current_account)
  end

  def destroy
    view = View.find(params[:id])
    view.destroy
    redirect_to viewed_my_account_path
  end
end
