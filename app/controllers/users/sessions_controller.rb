class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  respond_to :json
  after_filter :set_csrf_headers, only: [:create, :destroy]

  def create
    respond_to do |format|
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        data = {
            token: self.resource.authentication_token,
            email: self.resource.email,
            username: self.resource.username
        }
        render json: data, status: 201
      end
    end
  end

  protected
  def set_csrf_headers
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  # def failure
#   render :json => {:success => false, :errors => ["Login failed."]}
# end

# GET /resource/sign_in
# def new
#   super
# end

# POST /resource/sign_in
# def create
#   super
# end

# DELETE /resource/sign_out
# def destroy
#   super
# end

# protected

# If you have extra params to permit, append them to the sanitizer.
# def configure_sign_in_params
#   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
# end
end
