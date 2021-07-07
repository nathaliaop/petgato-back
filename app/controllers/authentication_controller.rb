class AuthenticationController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    url = nil
    # verifica se existe imagem
    if user.photo.attached?
      url = url_for(user.photo)
    end
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      time = Time.now + 24.hours.to_i
      render json: { user: user.attributes.merge(photo: url), token: token, exp: time.strftime("%m-%d-%Y %H:%M")}, status: :ok
    elsif !user
      render json: { errors: "Email not registered" }, status: :unauthorized
    else
      render json: { errors: "Wrong password" }, status: :unauthorized
    end
  end
  
  private
  def login_params
    params.permit(:email, :password)
  end
end