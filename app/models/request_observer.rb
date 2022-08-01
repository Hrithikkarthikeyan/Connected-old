class RequestObserver < ActiveRecord::Observer
  observe :request
  def before_destroy(request)
   
  end
end