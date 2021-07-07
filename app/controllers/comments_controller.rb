class CommentsController < ApplicationController
  include Paginable
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :authorize_request, except: [:index, :show]
  before_action :authorize_request_admin, only: [:destroy]

# GET /comments
def index
  @comments = Comment.page(current_page).per(per_page).map do | comment |
    user = User.find_by(id: comment.user_id)
    url = nil

    # verifica se existe imagem
    if user.photo.attached?
      url = url_for(user.photo)
    end
    user = user.attributes.merge(photo: url)

    replies = Reply.where(comment_id: comment.id).map do | reply |
      user_reply = User.find_by(id: reply.user_id)
      url_user_reply = nil
      # verifica se existe imagem
      if user_reply.photo.attached?
        url_user_reply = url_for(user_reply.photo)
      end
      user_reply = user_reply.attributes.merge(photo: url_user_reply)
      
      reply.attributes.merge(user_reply: user_reply)
    end

    comment.attributes.merge(user: user, replies: replies)
  end
  
  render json: @comments
end

  # GET /comments
  def show
    user = User.find_by(id: @comment.user_id)
    url_comment = nil

    # verifica se existe imagem
    if user.photo.attached?
      url_comment = url_for(user_comment.photo)
    end
    user = user.attributes.merge(photo: url_comment)

    replies = Reply.where(comment_id: @comment.id).map do | reply |
      user_reply = User.find_by(id: reply.user_id)
      url_user_reply = nil
      # verifica se existe imagem
      if user_reply.photo.attached?
        url_user_reply = url_for(user_reply.photo)
      end
      user_reply = user_reply.attributes.merge(photo: url_user_reply)
      
      reply.attributes.merge(user_reply: user_reply)
    end

  render json: @comment.attributes.merge(user: user, replies: replies), status: :ok
end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.permit(:description, :post_id, :user_id)
    end
end
