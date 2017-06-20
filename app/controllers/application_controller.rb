class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def layout
    render 'layouts/application'
  end
  def footer
    render 'layouts/footer'
  end
  # def index
  #   render 'users/index'
  # end
end
