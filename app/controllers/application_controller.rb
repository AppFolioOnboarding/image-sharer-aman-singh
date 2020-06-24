class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
    @images = Image.all.order(created_at: :asc)
  end
end
