 
 class ProductosController < ApplicationController

  def index
  
    @productos= Producto.all # muestra todos los productos
  end

  def show
   @producto= Producto.find(params[:id]) # muestra un producto por id
  end

  def nuevo
    @producto= Producto.new # crea una instancia del objeto Producto
  end

 end