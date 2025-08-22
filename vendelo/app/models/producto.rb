class Producto < ApplicationRecord
  include PgSearch::Model
   pg_search_scope :search_full_text, against: {
    titulo: 'A',
    descripcion: 'B',
  }
  

  has_one_attached :imagen # asociación con Active Storage para manejar imágenes

  # validaciones para que no acepte campos vacios
  validates :titulo, presence: true 
  validates :descripcion, presence: true
  validates :precio, presence: true

  belongs_to :categoria # asociación con la tabla categorias
end
