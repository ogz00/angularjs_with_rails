class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  skip_before_filter :verify_authenticity_token
  #protect_from_forgery with: :exception

  after_filter :set_csrf_cookie_for_ng

  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?

  def angular
    render '../../client/app/index.html'
  end

  def intercept_html_requests
    redirect_to('/') if request.format == Mime::HTML
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    message = 'Rails CSRF token error, please try again'
    render_with_protection(message.to_json, {:status => :unprocessable_entity})
  end

  def render_with_protection(object, parameters = {})
    render parameters.merge(content_type: 'application/json', text: ")]}',\n" + object.to_json)
  end

  protected
    # In Rails 4.2 and above
    def verified_request?
      super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def authenticate_user_from_token!
    authenticated = authenticate_with_http_token do |user_token, options|
      user_email = options[:email].presence
      user       = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, user_token)
        sign_in user, store: false
      else
        render json: 'Invalid authorization.'
      end
    end

    if !authenticated
      render json: 'No authorization provided.'
    end
  end


  def self.prepare_params_for action, *params_to_check
    PARAMS_FOR_ACTIONS["#{self.to_s}##{action}"] = params_to_check
  end

  def show_error error_code, description
    if !Rails.env.test?
      err_id = rand(1000..10000)
      puts "Error #{err_id.to_s} for parameters: "
      puts "[err_id:#{err_id.to_s}] Error code is #{error_code.to_s} and description: #{description.to_s}"
      params.each do |k, v|
        puts "[err_id:#{err_id}]  #{k.to_s} = #{v.to_s}"
      end
    end
    # redirect_to :controller => "error",:error_code => error_code, :description => description, :format => params[:format]
    # head @error_code
    response.headers["error"] = "true"
    response.headers["error_code"] = error_code.to_s
    @error_code = error_code
    @error_description = description
    @error_title = ErrorDescriptionTable[@error_code.to_i]
    render :template => 'layouts/error', :status => :bad_request, :format => :json
  end

end
