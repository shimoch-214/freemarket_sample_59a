class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :search_set
  private
  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:admin_user_name] && password == Rails.application.credentials[:admin_user_password]
    end
  end

  def search_set
    @q = Item.ransack(params[:q])
  end
end