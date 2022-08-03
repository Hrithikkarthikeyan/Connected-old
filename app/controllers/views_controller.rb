class ViewsController < ApplicationController
  def index
    @all_views = View.where(friend_id: current_account).order('created_at DESC')
    @views = []
    @all_views.each do |view|
      if is_valid(view)
        @views.append(view)
      end
    end
  end

  def destroy
    view = View.find(params[:id])
    view.destroy
    redirect_to viewed_my_account_path
  end

  def is_valid(view)
    created = view.created_at
    now = Time.now
    last_day = (now - created)/ 1.days
    if last_day <= 7
      return true
    else
      return false
    end
  end

  helper_method :is_valid
end
