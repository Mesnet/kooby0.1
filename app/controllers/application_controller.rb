class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def redirect_back(options = {})
    if request.referer
      redirect_to request.referer, options
    else
      redirect_to root_path, options
    end
  end

  protected

  def record_not_found
    redirect_to root_path
  end
  
end
