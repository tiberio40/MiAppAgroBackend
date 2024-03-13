class SessionsController < Devise::SessionsController
    respond_to :json

    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      respond_with(resource, serialize_options(resource))
    end
  
    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?

      user_json = {}

      if resource.is_banned == true
        user_json = { message: "Tu cuenta se encuntra bloqueada"}
      else
        user_json = {
          email: resource.email,
          token: current_token,
          fullname: resource.first_name + " " + resource.last_name,
          code_role: resource.user_role.code,
          name_role: resource.user_role.name
        }
      end    
      
      render json: user_json, status: :ok
    end

    private  
      def respond_with(resource, _opts = {})
        render json: resource
      end
  
      def respond_to_on_destroy
        head :no_content
      end
  
      def current_token
        request.env['warden-jwt_auth.token']
      end
  end