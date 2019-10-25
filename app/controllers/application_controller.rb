class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # before_action :basic if Rails.env == "production"

  # private
  # def basic
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == ENV["admin"] && password == ENV["password"]
  #   end
  # end
end