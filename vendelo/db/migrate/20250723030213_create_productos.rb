class CreateProductos < ActiveRecord::Migration[8.0]
  def change
    create_table :productos do |t|
      t.string :titulo
      t.text :descripcion
      t.integer :precio

      t.timestamps
    end
  end
end
