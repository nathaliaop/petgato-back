class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Bem-vindo(a) ao PetGatô!", content_type: "text/html")
  end

  def forgot_password_email(user)
    @user = user
    mail(to: @user.email, subject: "Solicitação de alteração de senha")
  end

  def reset_password_email(user)
    @user = user
    mail(to: @user.email, subject: "Senha redefinida com sucesso!")
  end
end