class AdminController < ApplicationController
  
  layout "public"
  
  before_filter :authorize_access, :except => [:index, :login]
  
  def index
    @user = User.new
    render(:action => "login")
  end
  
  def menu
  end
  
  def login
    @user = User.new(params[:user])
    logged_in_user = @user.try_to_login
    
    if logged_in_user
      #mark the user as logged in
      session[:user_id] = logged_in_user.id
      flash[:notice] = "You are now logged in."
      redirect_to(:controller => "admin", :action => "menu")
    else
      flash[:notice] = "Username/Password combination incorrect. Please make sure your caps lock key is off and try again."
      render(:action => "login")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "You are now logged out."
    redirect_to(:controller => "admin", :action => "index")
  end
    
end
