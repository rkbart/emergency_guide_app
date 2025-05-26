class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    unauthenticated_root_path
  end
end
