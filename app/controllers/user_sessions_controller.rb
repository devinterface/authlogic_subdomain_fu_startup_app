class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create], :if => :subdomain?
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = current_account.user_sessions.new
  end
  
  def create
    @user_session = current_account.user_sessions.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default application_root_url
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
