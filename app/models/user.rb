class User < ApplicationRecord
  has_secure_password
  has_one_attached :photo

  #Validação de novo usuário
  #Confere se o usuário cadastrou um nome e um email único e válido
  #Confere se a senha do usuário tem pelo menos 8 caracteres
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? }

  #Redefinição de senha
  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  private

  def generate_token
    SecureRandom.alphanumeric(10)
  end

end