class Categoria < ApplicationRecord

  validates :nombre, presence: true
  has_many :productos, dependent: :restrict_with_exception # asociación con la tabla productos  

end
