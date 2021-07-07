class PostsController < ApplicationController
  include Paginable
  before_action :authorize_request_admin, except: [:index, :show, :update_views]

  #Inclui o conteúdo e a image de banner nas postagens com paginação
  def index
    posts = Post.page(current_page).per(per_page).map do |post|
      content = post.content
      url = url_for(post.banner_image)
      comments = Comment.where(post_id: post.id).map do | comment |
        user = User.find_by(id: comment.user_id)
        url_user = nil

        # verifica se existe imagem
        if user.photo.attached?
          url_user = url_for(user.photo)
        end
        user = user.attributes.merge(photo: url_user)

        
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

      post.attributes.merge(content: content, banner_image: url, comments: comments)
    end
    render json: posts, status: :ok
  end
  
  #Inclui o conteúdo e a image de banner na postagem
  def show
    post = Post.find(params[:id])
    content = post.content
    url = url_for(post.banner_image)
    comments = Comment.where(post_id: post.id).map do | comment |
      user = User.find_by(id: comment.user_id)
      url_user = nil

      # verifica se existe imagem
      if user.photo.attached?
        url_user = url_for(user.photo)
      end
      user = user.attributes.merge(photo: url_user)

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

    render json: post.attributes.merge(content: content, banner_image: url, comments: comments), status: :ok
  end

  def create
    post = Post.new(title: params[:title], views: params[:views], banner_image: params[:banner_image], content: params[:content], tag_ids: params[:tag_ids])
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    render status: :ok
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post, status: :ok
    else
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end
  end

  def update_views
    post = Post.find(params[:id])
    if post.update(views: post.views+1)
      render json: post, status: :ok
    else
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end
  end

  private
  def post_params
    params.permit(:title, :views, :banner_image, :content, :tag_ids)
  end
  '''
  def post_views
    params.permit(:views)
  end
  '''
end
