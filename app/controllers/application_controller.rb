class ApplicationController < ActionController::Base
  rescue_from StandardError do |exception|
    # render what you want here
    render :json => exception.to_json, :status => :unprocessable_entity
    p "-----------------------------------------------"
  end
end
