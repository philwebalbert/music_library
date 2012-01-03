class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private #-----------------------------------------------
  
  def authorize_access
    if not session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => "admin", :action => "index")
      return false
    end
  end
end
