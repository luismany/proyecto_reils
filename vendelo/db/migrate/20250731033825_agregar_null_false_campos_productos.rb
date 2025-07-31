class AgregarNullFalseCamposProductos < ActiveRecord::Migration[8.0]
  def change
    change_column_null :productos, :titulo, false
    change_column_null :productos, :descripcion, false
    change_column_null :productos, :precio, false
  end
end
