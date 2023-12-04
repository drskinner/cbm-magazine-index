class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      flash[:error] = exception.message
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to public_welcome_path }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    articles_path
  end

  def after_sign_out_path_for(resource_or_scope)
    public_welcome_path
  end
end
