class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_start_time, :set_locale


  def find_by_id_or_redirect(model, id = params[:id])
    instance = model.find_by_id(id)

    if instance.nil?
      path = model == Version ? changes_path : polymorphic_path(model)
      redirect_to_with_flash path, :alert, 'not_found_instance', model
    else
      return instance
    end
  end


  def instance_path_args(instance = nil)
    args     = params[:controller].split(/::|\//)[0..1]
    args[-1] = instance.nil? ? args[-1].singularize : instance
    return args
  end
  helper_method :instance_path_args

  def redirect_to_with_flash(path, type, message, model = nil, name = '')
    model = model.nil? ? '' : model.model_name.human
    flash[type] = t("app.messages.#{message}", :model => model, :name => name)
    redirect_to path
  end


  def info_for_paper_trail
    { :mandator_id => current_user.nil? ? nil : current_user.mandator_id }
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end


  private

	def set_start_time
    @start_time = Time.now.usec
  end


	def set_locale
		I18n.locale = params[:locale] || session[:locale] || request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    I18n.locale = I18n.default_locale if !I18n.available_locales.include? I18n.locale
    session[:locale] = I18n.locale
  end


  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
