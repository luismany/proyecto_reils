class AddNotNullToCategoryName < ActiveRecord::Migration[8.0]
  def change
    # Asegurarse de que no haya valores nulos antes de aplicar la restricción
    change_column_null :categorias, :nombre, false
  end
end
