 
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

  def crear 
    @producto= Producto.new(parametros_producto) # se pasa los parametros que estan en la funcion parametros_producto

   # pp @producto # muestra por pantalla el contenido de una variable

   if @producto.save
      redirect_to productos_path

   else
     render :nuevo_producto
   end

  end

  private
  # esta funcion devuelve los parametros de producto
 def parametros_producto
    params.require(:producto).permit(:titulo, :descripcion, :precio) 
  end


 end