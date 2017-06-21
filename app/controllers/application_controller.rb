class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def layout
    render 'layouts/application'
  end
  def footer
    render 'layouts/footer'
  end

end
