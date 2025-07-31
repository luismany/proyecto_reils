class Producto < ApplicationRecord
  # validaciones para que no acepte campos vacios
  validates :titulo, presence: true 
  validates :descripcion, presence: true
  validates :precio, presence: true

end
