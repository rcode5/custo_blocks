class ApplicationController < ActionController::Base

  # Uncomment to require auth on all actions (and opt-out when necessary).
  # before_filter :require_login, except: [:not_authenticated]

  protect_from_forgery

end
