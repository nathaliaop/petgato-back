

class UsersController < ApplicationController
  include Paginable
  before_action :authorize_request, except: [:create, :forgot, :reset ]
  before_action :authorize_request_admin, only: [:index]
  
  #Inclui o conteúdo e a image de banner nas postagens com paginação
  def index
    users = User.page(current_page).per(per_page).map do |user|
      url = nil
      # verifica se existe imagem
      if user.photo.attached?
        url = url_for(user.photo)
      end
      user.attributes.merge(photo: url)
    end
    render json: users, status: :ok
  end

  def show
    user = User.find(params[:id])
    url = nil
    # verifica se existe imagem
    if user.photo.attached?
      url = url_for(user.photo)
    end
    render json: user.attributes.merge(photo: url), status: :ok
  end
  

  def create
    user = User.new(name: params[:name], email: params[:email], password: params[:password], photo: params[:photo])
    if user.save
      render json: user, status: :created
      UserMailer.welcome_email(user).deliver_now
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render status: :ok
    if !user
      render status: :not_found
    end
  end

  def update
    user = User.find(params[:id])
    url = nil
    if user.photo.attached? 
      url = url_for(user.photo)
    end
    if user.update(user_params)
      render json: user.attributes.merge(photo: url), status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def forgot
    if params[:email].blank?
      return render json: {error: 'Email not present'}
    end

    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      render status: :ok
      UserMailer.forgot_password_email(user).deliver_now
    else
      render json: {error: ['Email not registered']}, status: :not_found
    end
  end

  def reset
    token = params[:token].to_s
    email = params[:email]

    if token.blank?
      return render json: {error: 'Token not present'}
    end

    if email.blank?
      return render json: {error: 'Email not present'}
    end

    user = User.find_by(email: params[:email])

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render status: :ok
        UserMailer.reset_password_email(user).deliver_now
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  ['Link not valid or expired']}, status: :not_found
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :photo)
  end    
end
