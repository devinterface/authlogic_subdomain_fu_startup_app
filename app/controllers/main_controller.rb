class MainController < ApplicationController

  layout "application"
  before_filter :require_user
  
  def index

  end
end