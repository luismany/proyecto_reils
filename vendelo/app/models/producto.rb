class Producto < ApplicationRecord
  include PgSearch::Model
   pg_search_scope :search_full_text, against: {
    titulo: 'A',
    descripcion: 'B',
  }
  # pg_search_scope se utiliza para buscar en los campos titulo y descripcion de la tabla productos
  # 'A' y 'B' son los pesos asignados a cada campo para la busqueda
  # 'A' es el peso mas alto y 'B' es el peso mas bajo
  
  
   ORDER_BY = {
      recientes: "created_at DESC",
      caros: "precio DESC",
      baratos: "precio ASC"
    }
    # constante para ordenar los productos por recientes, caros o baratos.


  has_one_attached :imagen # asociación con Active Storage para manejar imágenes

  # validaciones para que no acepte campos vacios
  validates :titulo, presence: true 
  validates :descripcion, presence: true
  validates :precio, presence: true

  belongs_to :categoria # asociación con la tabla categorias
end
