class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def layout
    render 'layouts/application'
  end
end
