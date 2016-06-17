require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # We don't want to overcomplicate, so let this be just disabled
  # protect_from_forgery with: :exception
end
