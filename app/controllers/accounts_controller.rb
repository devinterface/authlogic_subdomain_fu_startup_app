class AccountsController < ApplicationController
  before_filter :require_no_user
  #before_filter { |c| c.require_no_subdomain new_account_path(:subdomain => false) } 

  def new
    @account = Account.new
    @account.users.build
  end

  def create
    @account = Account.new(params[:account])  
    if @account.save
      flash[:notice] = "Account registered! Go to <a href='http://#{@account.subdomain}.#{current_host}'>http://#{@account.subdomain}.#{current_host}</a> to log in."
      redirect_back_or_default public_root_url
    else
      render :action => :new
    end
  end
end
