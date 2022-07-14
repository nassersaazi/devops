class ApplicationController < ActionController::Base
  before_action :set_raven_context, :if => proc {Rails.env.production?}
  
  include Pundit
  after_action :verify_authorized, unless: :devise_controller?, except: :index
  after_action :verify_policy_scoped, only: :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_locale


  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end


  protected

  def user_not_authorized
    flash[:alert] = t ":pundit_exception", 
      scope: "pundit", 
      default: :default

    redirect_to request.referer || root_path
  end


  private

  def set_locale
    #byebug
    I18n.locale = params[:locale] || I18n.default_locale
    # This makes the test pass, see https://github.com/rails/rails/issues/12178
    Rails.application.routes.default_url_options[:locale] = I18n.locale
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

end
