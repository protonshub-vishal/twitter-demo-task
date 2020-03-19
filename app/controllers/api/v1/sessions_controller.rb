module Api
  module V1
    class SessionsController < Devise::SessionsController
    	def create
    		@user = warden.authenticate!(auth_options)
    		@token = Tiddle.create_and_return_token(@user, request, expires_in: 1.month)
    		render json: { message: "User successfully logged in", authentication_token: @token, status: :success }
    	end

    	def destroy
        Tiddle.expire_token(current_user, request) if current_user
        render json: {}
      end

      private

      # this is invoked before destroy and we have to override it
      def verify_signed_out_user; end

      def resource_name
        :user
      end
    end
  end
end