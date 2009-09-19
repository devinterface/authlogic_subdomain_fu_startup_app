class ApplicationController < ActionController::Base
  include App::Controller::Accounts
  include App::Controller::Users

  helper :all
  filter_parameter_logging :password, :password_confirmation

  layout :current_layout_name


  private

  def current_layout_name
    public_site? ? 'public' : 'application'
  end

  def public_site?
    account_subdomain = default_account_subdomain
  end

end
