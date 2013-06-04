class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_start_time, :set_locale


  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end


  private

	def set_start_time
    @start_time = Time.now.usec
  end

	def set_locale
		locale = params[:locale] || request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    I18n.locale = locale || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
