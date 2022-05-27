# This method could redirect you to 'show' page
class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index]

  def index; end

  protected

  def after_sign_in_path_for(_resource)
    # user_path(current_user)
    root_path
  end
end
