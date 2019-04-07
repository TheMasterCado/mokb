class AuthController < ApplicationController
  def token
    case permitted_params[:grant_type]
    when Enums::GrantType::PASSWORD
      if user = User.authenticate_with_password(permitted_params[:email], permitted_params[:password])
        render json: user.generate_tokens.to_json
      else
        render nothing: true, status: :unauthorized
      end
    when Enums::GrantType::REFRESH_TOKEN
      if user_refresh_token = User.authenticate_with_refresh_token(permitted_params[:refresh_token])
        user = user_refresh_token.user
        user_refresh_token.destroy
        render json: user.generate_tokens.to_json
      else
        render nothing: true, status: :unauthorized
      end
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy; end

  private

  def permitted_params
    params.permit(:grant_type, :refresh_token, :email, :password)
  end
end
