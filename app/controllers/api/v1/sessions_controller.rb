class Api::V1::SessionsController < Api::ApiControllers

  skip_before_action :require_login!, only: :create

# /sign_in
# retourn token si ok
# erreur si identifiants invalide : 401

  def create
    user = User.find_by(email: params[:email])

    if user.nil?
      render json: {success: false, message: 'Authentication failed'}, status: 401
    else
      if user.valid_password?(params[:password])
        user.generate_token
        render json: {success: true, auth_token: user.auth_token}
      else
        render json: {success: false, message: 'Authentication failed'}, status: 401
      end
    end
  end
end