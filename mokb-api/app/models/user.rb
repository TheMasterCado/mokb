class User < ApplicationRecord
  has_many :roles, through: :user_role
  has_many :refresh_tokens

  def generate_tokens
    refresh_payload = {
      id: id,
      email: email,
      exp: (Time.now + 1.week).to_i
    }
    access_payload = {
      id: id,
      email: email,
      exp: (Time.now + 15.minute).to_i
    }
    refresh_token = JWT.encode refresh_payload, Rails.application.credentials.jwt_secret, 'HS256'
    refresh_tokens << refresh_token
    access_token = JWT.encode access_payload, Rails.application.credentials.jwt_secret, 'HS256'
    { access_token: access_token, refresh_token: refresh_token }
  end

  def self.authenticate_with_refresh_token(token)
    if user_refresh_token = UserRefreshToken.find_by(token: token)
      begin
        JWT.decode token, Rails.application.credentials.jwt_secret, true, algorithm: 'HS256'
        user_refresh_token
      rescue StandardError => exception
        false
      end
    else
      false
    end
  end

  def self.authenticate_with_password(email, password)
    if user = User.find_by(email: email)
      if user.encrypted_password == User.digest(password)
        user
      else
        false
      end
    else
      false
    end
  end

  def self.digest(string); end
end
