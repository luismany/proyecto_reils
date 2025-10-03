class User < ApplicationRecord
 
  has_secure_password

  validates :email, presence: true, uniqueness: true,
  format: {
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: 'debe ser una direccion de email valida' } #el email debe tener un formato valido

  validates :username, presence: true, uniqueness: true,
  length: { minimum: 3, maximum: 15 }, #el nombre de usuario debe tener entre 3 y 15 caracteres
  format: { 
    with: /\A[a-zA-Z0-9_]+\z/, 
    message: 'solo puede contener letras, numeros y guiones bajos' } #el nombre de usuario solo puede contener letras, numeros y guiones bajos
  validates :password, presence: true, length: { minimum: 6 }  

  has_many :productos, dependent: :destroy # un usuario puede tener muchos productos, si se elimina el usuario se eliminan sus productos

  # convierte a minusculas el email y el username antes de guardarlo en la base de datos
  before_save :downcase_fields

  private
  def downcase_fields
    self.email = email.downcase
    self.username = username.downcase
  end

  
end
