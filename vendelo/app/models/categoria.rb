class Categoria < ApplicationRecord
  #validaciones
  validates :nombre, presence: true # valida que el nombre este presente

  has_many :productos, dependent: :restrict_with_exception # asociación con la tabla productos  

end
