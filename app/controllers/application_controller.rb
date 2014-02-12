class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  def ensure_json_request
    unless request.headers["Content-Type"] == 'application/json' then
      render :nothing => true, :status => 406
    end
  end
end
