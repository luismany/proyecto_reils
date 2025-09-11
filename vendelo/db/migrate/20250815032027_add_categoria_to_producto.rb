class AddCategoriaToProducto < ActiveRecord::Migration[8.0]
  def change
    # Agrega una referencia a la tabla categorias en la tabla productos
    add_reference :productos, :categoria, null: false, foreign_key: true
  end
end
