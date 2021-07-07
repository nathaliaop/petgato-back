class ApplicationController < ActionController::API
  def not_found
    render status: :not_found
  end
      
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = JsonWebToken.decode(header)
      current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError => error
      render json: { errors: "User not logged" }, status: :unauthorized
    end
  end

  def authorize_request_admin
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = JsonWebToken.decode(header)
      current_user = User.find(decoded[:user_id])
    if !current_user.is_admin
      render json: { errors: "User is not admin" }, status: :unauthorized
    end
    rescue JWT::DecodeError => error
      render json: { errors: "User not logged" }, status: :unauthorized
    end
  end
end