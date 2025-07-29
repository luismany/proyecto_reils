 
 class ProductosController < ApplicationController

  def index
  
    @productos= Producto.all # muestra todos los productos
  end

  def show
   @productos= Producto.find(params[:id]) # muestra un producto por id
  end

 end